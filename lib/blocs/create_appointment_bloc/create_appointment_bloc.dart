import 'package:appointment_repository/appointment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_appointment_event.dart';
part 'create_appointment_state.dart';

class CreateAppointmentBloc
    extends Bloc<CreateAppointmentEvent, CreateAppointmentState> {
  AppointmentRepository _appointmentRepository;

  CreateAppointmentBloc({required AppointmentRepository appointmentRepository})
    : _appointmentRepository = appointmentRepository,
      super(CreateAppointmentInitial()) {
    on<CreateAppointment>((event, emit) async {
      emit(CreateAppointmentLoading());
      try {
        Appointment appointment = await _appointmentRepository
            .createAppointment(event.appointment);

        emit(CreateAppointmentSuccess(appointment));
      } catch (e) {
        emit(CreateAppointmentFailure());
      }
    });
  }
}
