part of 'create_appointment_bloc.dart';

abstract class CreateAppointmentState extends Equatable {
  const CreateAppointmentState();

  @override
  List<Object> get props => [];
}

class CreateAppointmentInitial extends CreateAppointmentState {}

class CreateAppointmentLoading extends CreateAppointmentState {}

class CreateAppointmentFailure extends CreateAppointmentState {}

class CreateAppointmentSuccess extends CreateAppointmentState {
  final Appointment appointment;
  const CreateAppointmentSuccess(this.appointment);
}
