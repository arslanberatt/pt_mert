import 'package:appointment_repository/src/models/appointment_status.dart';
import 'package:customer_repository/customer_repository.dart';
import 'models/models.dart';

abstract class AppointmentRepository {
  Future<Appointment> createAppointment(Appointment appointment);

  Future<List<Appointment>> getAppointments();

  Future<Appointment> updateAppointment(Appointment appointment);
  Future<void> updateAppointmentStatus(
    Appointment appointment,
    String appointmentId,
    AppointmentStatus status,
    Customer customer,
  );
}
