import 'package:equatable/equatable.dart';
import 'package:transaction_repository/transaction_repository.dart';

sealed class CreateTransactionState extends Equatable {
  const CreateTransactionState();

  @override
  List<Object> get props => [];
}

final class CreateTransactionInitial extends CreateTransactionState {}

final class CreateTransactionFailure extends CreateTransactionState {}

final class CreateTransactionLoading extends CreateTransactionState {}

final class CreateTransactionSuccess extends CreateTransactionState {
  final Transaction transaction;
  const CreateTransactionSuccess(this.transaction);
}
