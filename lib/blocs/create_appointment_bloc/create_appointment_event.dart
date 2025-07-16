part of 'create_appointment_bloc.dart';

abstract class CreateAppointmentEvent extends Equatable {
  const CreateAppointmentEvent();

  @override
  List<Object> get props => [];
}

class CreateAppointment extends CreateAppointmentEvent {
  final Appointment appointment;

  const CreateAppointment(this.appointment);
}