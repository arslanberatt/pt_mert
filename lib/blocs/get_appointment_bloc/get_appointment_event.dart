part of 'get_appointment_bloc.dart';

sealed class GetAppointmentEvent extends Equatable {
  const GetAppointmentEvent();

  @override
  List<Object> get props => [];
}

class GetAppointment extends GetAppointmentEvent {}
