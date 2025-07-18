import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transaction_repository/transaction_repository.dart';

part 'get_transaction_event.dart';
part 'get_transaction_state.dart';

class GetTransactionBloc
    extends Bloc<GetTransactionEvent, GetTransactionState> {
  TransactionRepository _transactionRepository;
  GetTransactionBloc({required TransactionRepository transactionRepository})
    : _transactionRepository = transactionRepository,
      super(GetTransactionInitial()) {
    on<GetTransaction>((event, emit) async {
      emit(GetTransactionLoading());
      try {
        List<Transaction> Transactions = await _transactionRepository
            .getTransaction();
        emit(GetTransactionSuccess(Transactions));
      } catch (e) {
        emit(GetTransactionFailure());
      }
    });
  }
}
