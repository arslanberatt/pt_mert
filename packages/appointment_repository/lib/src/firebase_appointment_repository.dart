import 'dart:developer';
import 'package:appointment_repository/src/models/appointment_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:customer_repository/customer_repository.dart';
import 'package:appointment_repository/appointment_repository.dart';

class FirebaseAppointmentRepository implements AppointmentRepository {
  final appointmentsCollection = FirebaseFirestore.instance.collection(
    'appointments',
  );
  final customersCollection = FirebaseFirestore.instance.collection(
    'customers',
  );

  @override
  Future<Appointment> createAppointment(Appointment appointment) async {
    try {
      final newId = const Uuid().v1();
      final entity = appointment.copyWith(appointmentId: newId).toEntity();

      await appointmentsCollection.doc(newId).set(entity.toDocument());

      return appointment.copyWith(appointmentId: newId);
    } catch (e) {
      log("[ERROR][createAppointment] $e");
      rethrow;
    }
  }

  @override
  Future<List<Appointment>> getAppointments(List<Customer> customers) async {
    try {
      final snapshot = await appointmentsCollection.get();

      return snapshot.docs.map((doc) {
        final entityData = doc.data();
        final customerIdFromEntity = entityData['customerId'] as String;

        final customer = customers.firstWhere(
          (c) => c.customerId == customerIdFromEntity,
          orElse: () => Customer.empty,
        );
        final entity = AppointmentEntity.fromDocument(entityData);
        return Appointment.fromEntity(entity, customer);
      }).toList();
    } catch (e) {
      log("[ERROR][getAppointments] $e");
      rethrow;
    }
  }

  @override
  Future<Appointment> updateAppointment(Appointment appointment) async {
    try {
      // Bir Firestore işlemi başlat
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final appointmentRef = appointmentsCollection.doc(
          appointment.appointmentId,
        );
        final customerRef = customersCollection.doc(
          appointment.customer.customerId,
        );

        // Mevcut randevu belgesini getir (ders sayısını düşürme mantığı için)
        final existingAppointmentSnapshot = await transaction.get(
          appointmentRef,
        );
        final existingAppointmentData = existingAppointmentSnapshot.data();
        final AppointmentStatus oldStatus = existingAppointmentData != null
            ? AppointmentStatus.values.firstWhere(
                (e) => e.name == existingAppointmentData['status'],
                orElse: () => AppointmentStatus.pending,
              )
            : AppointmentStatus
                  .pending; // Randevu yoksa veya veri null ise varsayılan

        // Randevuyu güncelle
        transaction.update(appointmentRef, appointment.toEntity().toDocument());

        // Önemli: Randevunun durumu "pending" (beklemede) iken "approved" (onaylandı) olduysa
        // veya "cancelled" (iptal edildi) iken "approved" olduysa ders sayısını düşür.
        // Bu kontrol, aynı randevunun tekrar tekrar güncellenmesinde gereksiz düşüşleri engeller.
        if (oldStatus != AppointmentStatus.completed &&
            appointment.status == AppointmentStatus.completed) {
          final customerSnapshot = await transaction.get(customerRef);

          if (customerSnapshot.exists) {
            final customerEntity = CustomerEntity.fromDocument(
              customerSnapshot.data()!,
            );
            final currentLessonCount = customerEntity.trainingCount;

            if (currentLessonCount > 0) {
              transaction.update(customerRef, {
                'lessonCount': currentLessonCount - 1,
              });
              log(
                "Müşteri ${appointment.customer.name}'ın ders sayısı bir azaltıldı.",
              );
            } else {
              log(
                "Müşteri ${appointment.customer.name}'ın ders sayısı zaten 0. Daha fazla azaltılamaz.",
              );
            }
          } else {
            log(
              "Müşteri ${appointment.customer.name} bulunamadı. Ders sayısı düşürülemedi.",
            );
          }
        } else if (oldStatus == AppointmentStatus.completed &&
            appointment.status != AppointmentStatus.completed) {
          log(
            "Randevu durumu onaydan başka bir duruma geçti. Ders sayısı geri artırılmadı.",
          );
        }
      });
      return appointment;
    } catch (e) {
      log("[ERROR][updateAppointment] $e");
      rethrow;
    }
  }

  @override
  Future<Customer> updateCustomer(Customer customer) async {
    try {
      await customersCollection
          .doc(customer.customerId)
          .update(customer.toEntity().toDocument());
      return customer;
    } catch (e) {
      log("[ERROR][updateCustomer] ${e.toString()}");
      rethrow;
    }
  }
}
