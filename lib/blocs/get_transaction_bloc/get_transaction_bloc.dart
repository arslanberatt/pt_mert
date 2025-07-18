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
        List<Transaction> transaction = await _transactionRepository
            .getTransaction();
        emit(GetTransactionSuccess(transaction));
      } catch (e) {
        emit(GetTransactionFailure());
      }
    });
  }
}
