import 'package:appointment_repository/appointment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_appointment_event.dart';
part 'update_appointment_state.dart';

class UpdateAppointmentBloc
    extends Bloc<UpdateAppointmentEvent, UpdateAppointmentState> {
  final AppointmentRepository _appointmentRepository;
  UpdateAppointmentBloc({required AppointmentRepository appointmentRepository})
    : _appointmentRepository = appointmentRepository,
      super(UpdateAppointmentInitial()) {
    on<UpdateAppointment>((event, emit) async {
      emit(UpdateAppointmentLoading());
      try {
        Appointment appointment = await _appointmentRepository
            .updateAppointment(event.appointment);
        emit(UpdateAppointmentSuccess(appointment));
      } catch (e) {
        emit(UpdateAppointmentFailure());
      }
    });
  }
}
