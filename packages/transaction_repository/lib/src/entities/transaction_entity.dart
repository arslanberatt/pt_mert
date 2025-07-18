import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:transaction_repository/src/models/transaction_type.dart';

class TransactionEntity extends Equatable {
  final String transactionId;
  final String title;
  final double amount;
  final TransactionType type;
  final DateTime createdAt;
  final bool isActive;

  const TransactionEntity({
    required this.transactionId,
    required this.title,
    required this.amount,
    required this.createdAt,
    required this.type,
    required this.isActive,
  });

  Map<String, dynamic> toDocument() {
    return {
      'transactionId': transactionId,
      'title': title,
      'amount': amount,
      'createdAt': createdAt,
      'type': type.name,
      'isActive': isActive,
    };
  }

  /// Firestore'dan okumak için
  static TransactionEntity fromDocument(Map<String, dynamic> doc) {
    return TransactionEntity(
      transactionId: doc['transactionId'] as String? ?? '',
      title: doc['title'] as String? ?? '',
      amount: doc['amount'] as double? ?? 0.0,
      createdAt: (doc['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      type: TransactionType.expense,
      isActive: doc['isActive'] as bool? ?? true,
    );
  }

  @override
  List<Object?> get props => [
    transactionId,
    title,
    amount,
    createdAt,
    type,
    isActive,
  ];

  @override
  String toString() {
    return ''' TransactionEntity: {
      transactionId: $transactionId
      title: $title
      amount: $amount
      createdAt: $createdAt
      type: $type
      isActive: $isActive
    }''';
  }
}
