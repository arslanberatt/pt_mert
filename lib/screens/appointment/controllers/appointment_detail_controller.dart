import 'package:appointment_repository/appointment_repository.dart';
import 'package:appointment_repository/src/models/appointment_status.dart';

class AppointmentDetailController {
  final AppointmentRepository appointmentRepository;

  AppointmentDetailController({required this.appointmentRepository});

  Future<Appointment> updateStatus(
    Appointment appointment,
    AppointmentStatus status,
  ) async {
    final updated = appointment.copyWith(status: status);
    await appointmentRepository.updateAppointment(updated);
    
    return updated;
    
  }

  Future<Appointment> updateDate(
    Appointment appointment,
    DateTime newDateTime,
  ) async {
    final updated = appointment.copyWith(date: newDateTime);
    await appointmentRepository.updateAppointment(updated);
    return updated;
  }

  Future<Appointment> updatePrice(
    Appointment appointment,
    double newPrice,
  ) async {
    final updated = appointment.copyWith(price: newPrice);
    return await appointmentRepository.updateAppointment(updated);
  }
}
