// appointment_repository/lib/src/entities/appointment_entity.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  String appointmentId;
  Customer customer;
  DateTime date;
  String status;
  double? price;
  DateTime createdAt;

  AppointmentEntity({
    required this.appointmentId,
    required this.customer,
    required this.date,
    required this.status,
    this.price,
    required this.createdAt,
  });

  Map<String, dynamic> toDocument() {
    return {
      'appointmentId': appointmentId,
      'customer': customer.toEntity().toDocument(),
      'date': date,
      'status': status,
      'price': price,
      'createdAt': createdAt,
    };
  }

  static AppointmentEntity fromDocument(Map<String, dynamic> doc) {
    return AppointmentEntity(
      appointmentId: doc['appointmentId'] as String? ?? '',
      customer: Customer.fromEntity(
        CustomerEntity.fromDocument(doc['customer']),
      ),
      date: (doc['date'] as Timestamp).toDate(),
      status: doc['status'] as String? ?? 'pending',
      price: (doc['price'] as num?)?.toDouble(),
      createdAt: (doc['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
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
    return ''' AppointmentEntity: {
      appointmentId: $appointmentId
      customer: $customer
      date: $date
      status: $status
      price: $price
      createdAt: $createdAt
    }''';
  }
}
