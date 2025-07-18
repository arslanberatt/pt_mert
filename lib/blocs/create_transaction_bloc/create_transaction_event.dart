import 'package:equatable/equatable.dart';
import 'package:transaction_repository/transaction_repository.dart';

sealed class CreateTransactionEvent extends Equatable {
  const CreateTransactionEvent();

  @override
  List<Object> get props => [];
}

class CreateTransaction extends CreateTransactionEvent {
  final Transaction transaction;

  const CreateTransaction(this.transaction);
}
