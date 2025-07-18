import 'package:bloc/bloc.dart';
import 'package:pt_mert/blocs/create_transaction_bloc/create_transaction_event.dart';
import 'package:pt_mert/blocs/create_transaction_bloc/create_transaction_state.dart';
import 'package:transaction_repository/transaction_repository.dart';

class CreateTransactionBloc
    extends Bloc<CreateTransactionEvent, CreateTransactionState> {
  final TransactionRepository _transactionRepository;

  CreateTransactionBloc({required TransactionRepository transactionRepository})
    : _transactionRepository = transactionRepository,
      super(CreateTransactionInitial()) {
    on<CreateTransaction>((event, emit) async {
      emit(CreateTransactionLoading());
      try {
        Transaction transaction = await _transactionRepository
            .createTransaction(event.transaction);
        emit(CreateTransactionSuccess(transaction));
      } catch (e) {
        emit(CreateTransactionFailure());
      }
    });
  }
}
