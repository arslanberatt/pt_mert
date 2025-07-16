enum AppointmentStatus {
  pending('pending'),
  completed('completed'),
  cancelled('cancelled'),
  missed('missed');

  final String value;
  const AppointmentStatus(this.value);

  factory AppointmentStatus.fromString(String? statusString) {
    if (statusString == null) return AppointmentStatus.pending;
    return AppointmentStatus.values.firstWhere(
      (e) => e.value == statusString,
      orElse: () => AppointmentStatus.pending,
    );
  }
}
