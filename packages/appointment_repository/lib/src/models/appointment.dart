import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';
import '../entities/entities.dart';
import './appointment_status.dart';

class Appointment extends Equatable {
  String appointmentId;
  Customer customer;
  DateTime date;
  AppointmentStatus status;
  double? price;
  DateTime createdAt;

  Appointment({
    required this.appointmentId,
    required this.customer,
    required this.date,
    this.status = AppointmentStatus.pending,
    this.price,
    required this.createdAt,
  });

  Appointment copyWith({
    String? appointmentId,
    Customer? customer,
    DateTime? date,
    AppointmentStatus? status,
    double? price,
    DateTime? createdAt,
  }) {
    return Appointment(
      appointmentId: appointmentId ?? this.appointmentId,
      customer: customer ?? this.customer,
      date: date ?? this.date,
      status: status ?? this.status,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static final empty = Appointment(
    appointmentId: '',
    customer: Customer.empty,
    date: DateTime.now(),
    status: AppointmentStatus.pending,
    price: 0,
    createdAt: DateTime.now(),
  );

  bool get isEmpty => this == Appointment.empty;
  bool get isNotEmpty => this != Appointment.empty;

  AppointmentEntity toEntity() {
    return AppointmentEntity(
      appointmentId: appointmentId,
      customer: customer,
      date: date,
      status: status.value,
      price: price,
      createdAt: createdAt,
    );
  }

  static Appointment fromEntity(AppointmentEntity entity) {
    return Appointment(
      appointmentId: entity.appointmentId,
      customer: entity.customer,
      date: entity.date,
      status: AppointmentStatus.fromString(entity.status),
      price: entity.price,
      createdAt: entity.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    appointmentId,
    customer,
    date,
    status,
    price,
    createdAt,
  ];

  @override
  String toString() {
    return ''' Appointment: {
      appointmentId: $appointmentId
      customer: $customer
      date: $date
      status: $status
      price: $price
      createdAt: $createdAt
    }''';
  }
}
