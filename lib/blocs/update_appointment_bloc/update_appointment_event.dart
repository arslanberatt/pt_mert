part of 'update_appointment_bloc.dart';

sealed class UpdateAppointmentEvent extends Equatable {
  const UpdateAppointmentEvent();

  @override
  List<Object> get props => [];
}

class UpdateAppointment extends UpdateAppointmentEvent {
  final Appointment appointment;

  const UpdateAppointment(this.appointment);
}
