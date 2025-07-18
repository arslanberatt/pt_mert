part of 'get_transaction_bloc.dart';

sealed class GetTransactionState extends Equatable {
  const GetTransactionState();

  @override
  List<Object> get props => [];
}

final class GetTransactionInitial extends GetTransactionState {}

final class GetTransactionFailure extends GetTransactionState {}

final class GetTransactionLoading extends GetTransactionState {}

final class GetTransactionSuccess extends GetTransactionState {
  final List<Transaction> transaction;
  const GetTransactionSuccess(this.transaction);
}
