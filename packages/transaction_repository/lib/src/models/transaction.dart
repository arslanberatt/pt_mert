import 'package:equatable/equatable.dart';
import 'package:transaction_repository/src/models/transaction_type.dart';
import '../entities/entities.dart';

// ignore: must_be_immutable
class Transaction extends Equatable {
  String transactionId;
  String title;
  double amount;
  TransactionType type;
  DateTime createdAt;
  bool isActive;

  Transaction({
    required this.transactionId,
    required this.title,
    required this.amount,
    required this.createdAt,
    required this.type,
    required this.isActive,
  });

  Transaction copyWith({
    String? transactionId,
    String? title,
    double? amount,
    DateTime? createdAt,
    TransactionType? type,
    bool? isActive,
  }) {
    return Transaction(
      transactionId: transactionId ?? this.transactionId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
    );
  }

  static final empty = Transaction(
    transactionId: '',
    title: '',
    amount: 0.0,
    createdAt: DateTime.now(),
    type: TransactionType.expense,
    isActive: true,
  );

  bool get isEmpty => this == Transaction.empty;
  bool get isNotEmpty => this != Transaction.empty;

  TransactionEntity toEntity() {
    return TransactionEntity(
      transactionId: transactionId,
      title: title,
      amount: amount,
      createdAt: createdAt,
      type: type,
      isActive: isActive,
    );
  }

  static Transaction fromEntity(TransactionEntity entity) {
    return Transaction(
      transactionId: entity.transactionId,
      title: entity.title,
      amount: entity.amount,
      createdAt: entity.createdAt,
      type: entity.type,
      isActive: entity.isActive,
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
    return ''' Transaction: {
      transactionId: $transactionId
      title: $title
      amount: $amount
      createdAt: $createdAt
      type: $type
      isActive: $isActive
    }''';
  }
}
