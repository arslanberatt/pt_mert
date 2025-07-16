// appointment_repository/lib/src/entities/appointment_entity.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  final String appointmentId;
  final Customer customer;
  final DateTime date;
  final String status;
  final double? price;
  final bool notified15MinBefore;
  final DateTime createdAt;

  const AppointmentEntity({
    required this.appointmentId,
    required this.customer,
    required this.date,
    required this.status,
    this.price,
    this.notified15MinBefore = false,
    required this.createdAt,
  });

  Map<String, dynamic> toDocument() {
    return {
      'appointmentId': appointmentId,
      'customer': customer.toEntity().toDocument(),
      'date': date,
      'status': status,
      'price': price,
      'notified15MinBefore': notified15MinBefore,
      'createdAt': createdAt,
    };
  }

  static AppointmentEntity fromDocument(Map<String, dynamic> doc) {
    return AppointmentEntity(
      appointmentId: doc['appointmentId'] as String? ?? '',
      customer: Customer.fromEntity(
        CustomerEntity.fromDocument(doc['customer'] as Map<String, dynamic>),
      ),
      date: (doc['date'] as Timestamp).toDate(),
      status: doc['status'] as String? ?? 'pending',
      price: (doc['price'] as num?)?.toDouble(),
      notified15MinBefore: doc['notified15MinBefore'] as bool? ?? false,
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
    notified15MinBefore,
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
      notified15MinBefore: $notified15MinBefore
      createdAt: $createdAt
    }''';
  }
}
