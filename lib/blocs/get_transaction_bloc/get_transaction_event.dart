part of 'get_transaction_bloc.dart';

sealed class GetTransactionEvent extends Equatable {
  const GetTransactionEvent();

  @override
  List<Object> get props => [];
}

class GetTransaction extends GetTransactionEvent {}
