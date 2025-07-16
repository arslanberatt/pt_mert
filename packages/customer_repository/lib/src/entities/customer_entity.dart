import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final String customerId;
  final String name;
  final String phone;
  final DateTime createdAt;
  final int trainingCount;
  final DateTime? lastTrainingDate;
  final String? note;
  final bool isActive;

  const CustomerEntity({
    required this.customerId,
    required this.name,
    required this.phone,
    required this.createdAt,
    required this.trainingCount,
    this.lastTrainingDate,
    this.note,
    required this.isActive,
  });

  /// Firestore'a yazmak için
  Map<String, dynamic> toDocument() {
    return {
      'customerId': customerId,
      'name': name,
      'phone': phone,
      'createdAt': createdAt,
      'trainingCount': trainingCount,
      'lastTrainingDate': lastTrainingDate,
      'note': note,
      'isActive': isActive,
    };
  }

  /// Firestore'dan okumak için
  static CustomerEntity fromDocument(Map<String, dynamic> doc) {
    return CustomerEntity(
      customerId: doc['customerId'] as String? ?? '',
      name: doc['name'] as String? ?? '',
      phone: doc['phone'] as String? ?? '',
      createdAt: (doc['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      trainingCount: doc['trainingCount'] as int? ?? 0,
      lastTrainingDate: (doc['lastTrainingDate'] as Timestamp?)?.toDate(),
      note: doc['note'] as String?,
      isActive: doc['isActive'] as bool? ?? true,
    );
  }

  @override
  List<Object?> get props => [
    customerId,
    name,
    phone,
    createdAt,
    trainingCount,
    lastTrainingDate,
    note,
    isActive,
  ];

  @override
  String toString() {
    return ''' CustomerEntity: {
      customerId: $customerId
      name: $name
      phone: $phone
      createdAt: $createdAt
      trainingCount: $trainingCount
      lastTrainingDate: $lastTrainingDate
      note: $note
      isActive: $isActive
    }''';
  }
}
