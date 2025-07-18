import 'package:equatable/equatable.dart';
import 'package:transaction_repository/transaction_repository.dart';

sealed class UpdateTransactionState extends Equatable {
  const UpdateTransactionState();

  @override
  List<Object> get props => [];
}

final class UpdateTransactionInitial extends UpdateTransactionState {}

final class UpdateTransactionFailure extends UpdateTransactionState {}

final class UpdateTransactionLoading extends UpdateTransactionState {}

final class UpdateTransactionSuccess extends UpdateTransactionState {
  final Transaction transaction;
  const UpdateTransactionSuccess(this.transaction);
}
