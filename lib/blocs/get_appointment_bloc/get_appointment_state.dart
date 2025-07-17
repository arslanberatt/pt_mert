part of 'get_appointment_bloc.dart';

sealed class GetAppointmentState extends Equatable {
  const GetAppointmentState();

  @override
  List<Object> get props => [];
}

final class GetAppointmentInitial extends GetAppointmentState {}

final class GetAppointmentFailure extends GetAppointmentState {}

final class GetAppointmentLoading extends GetAppointmentState {}

final class GetAppointmentSuccess extends GetAppointmentState {
  final List<Customer> customer;
  final List<Appointment> appointments;
  const GetAppointmentSuccess(this.customer, this.appointments);
}
