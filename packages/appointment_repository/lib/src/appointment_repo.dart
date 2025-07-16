import 'package:customer_repository/customer_repository.dart';
import 'models/models.dart';

abstract class AppointmentRepository {
  Future<Appointment> createAppointment(Appointment appointment);

  Future<List<Appointment>> getAppointments(List<Customer> customers);

  Future<Appointment> updateAppointment(Appointment appointment);

  Future<Customer> updateCustomer(Customer customer);
}
