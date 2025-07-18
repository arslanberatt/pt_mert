import 'package:bloc/bloc.dart';
import 'package:appointment_repository/src/models/appointment_status.dart';
import 'package:appointment_repository/appointment_repository.dart';
import 'package:customer_repository/customer_repository.dart';
import 'update_appointment_state.dart';

class UpdateAppointmentCubit extends Cubit<UpdateAppointmentState> {
  final AppointmentRepository repository;
  final Customer customer;

  UpdateAppointmentCubit({
    required Appointment appointment,
    required this.repository,
    required this.customer,
  }) : super(UpdateAppointmentState(appointment: appointment));

  Future<void> updateDate(DateTime newDate) async {
    emit(state.copyWith(isLoading: true));
    final updated = state.appointment.copyWith(date: newDate);
    await repository.updateAppointment(updated);
    emit(state.copyWith(appointment: updated, isLoading: false));
  }

  Future<void> updatePrice(double price) async {
    emit(state.copyWith(isLoading: true));
    final updated = state.appointment.copyWith(price: price);
    await repository.updateAppointment(updated);
    emit(state.copyWith(appointment: updated, isLoading: false));
  }

  Future<void> updateStatus(AppointmentStatus status) async {
    emit(state.copyWith(isLoading: true));
    final updated = state.appointment.copyWith(status: status);

    await repository.updateAppointmentStatus(
      updated,
      updated.appointmentId,
      status,
      customer,
    );
    emit(state.copyWith(appointment: updated, isLoading: false));
  }
}
