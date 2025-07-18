import 'dart:developer';
import 'package:appointment_repository/src/models/appointment_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:uuid/uuid.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:appointment_repository/appointment_repository.dart';
import 'package:transaction_repository/transaction_repository.dart';
import 'package:transaction_repository/src/models/transaction_type.dart';

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
      appointment.appointmentId = Uuid().v1();
      appointmentsCollection
          .doc(appointment.appointmentId)
          .set(appointment.toEntity().toDocument());
      return appointment;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Appointment>> getAppointments() async {
    try {
      return appointmentsCollection.get().then(
        (value) => value.docs
            .map(
              (e) => Appointment.fromEntity(
                AppointmentEntity.fromDocument(e.data()),
              ),
            )
            .toList(),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateAppointmentStatus(
    Appointment appointment,
    String appointmentId,
    AppointmentStatus status,
    Customer customer,
  ) async {
    try {
      // 1. Randevu durumunu güncelle
      await appointmentsCollection.doc(appointmentId).update({
        "status": status.value,
      });

      await customersCollection.doc(customer.customerId).update({
        ...customer
            .copyWith(
              trainingCount: customer.trainingCount > 0
                  ? customer.trainingCount - 1
                  : 0,
              lastTrainingDate: appointment.date,
            )
            .toEntity()
            .toDocument(),
      });

      if ((appointment.price ?? 0) > 0) {
        final transaction = Transaction(
          transactionId: const Uuid().v4(),
          title: 'Randevu - ${customer.name}',
          amount: appointment.price!,
          type: TransactionType.income,
          createdAt: DateTime.now(),
          isActive: true,
        );
        await FirebaseTransactionRepository().createTransaction(transaction);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Appointment> updateAppointment(Appointment appointment) async {
    try {
      await appointmentsCollection
          .doc(appointment.appointmentId)
          .update(appointment.toEntity().toDocument());
      return appointment;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
