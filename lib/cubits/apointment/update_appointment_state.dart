import 'package:appointment_repository/appointment_repository.dart';

class UpdateAppointmentState {
  final Appointment appointment;
  final bool isLoading;
  final String? error;

  UpdateAppointmentState({
    required this.appointment,
    this.isLoading = false,
    this.error,
  });

  UpdateAppointmentState copyWith({
    Appointment? appointment,
    bool? isLoading,
    String? error,
  }) {
    return UpdateAppointmentState(
      appointment: appointment ?? this.appointment,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
