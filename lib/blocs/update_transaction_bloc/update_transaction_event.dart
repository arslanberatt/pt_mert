import 'package:equatable/equatable.dart';
import 'package:transaction_repository/transaction_repository.dart';

sealed class UpdateTransactionEvent extends Equatable {
  const UpdateTransactionEvent();

  @override
  List<Object> get props => [];
}

class UpdateTransaction extends UpdateTransactionEvent {
  final Transaction transaction;

  const UpdateTransaction(this.transaction);
}
