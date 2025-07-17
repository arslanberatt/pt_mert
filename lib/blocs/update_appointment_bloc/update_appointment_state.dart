part of 'update_appointment_bloc.dart';

sealed class UpdateAppointmentState extends Equatable {
  const UpdateAppointmentState();

  @override
  List<Object> get props => [];
}

final class UpdateAppointmentInitial extends UpdateAppointmentState {}

final class UpdateAppointmentFailure extends UpdateAppointmentState {}

final class UpdateAppointmentLoading extends UpdateAppointmentState {}

final class UpdateAppointmentSuccess extends UpdateAppointmentState {
  final Appointment appointment;
  const UpdateAppointmentSuccess(this.appointment);
}
