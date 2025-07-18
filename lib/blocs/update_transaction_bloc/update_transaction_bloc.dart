import 'package:bloc/bloc.dart';
import 'package:pt_mert/blocs/update_transaction_bloc/update_transaction_event.dart';
import 'package:pt_mert/blocs/update_transaction_bloc/update_transaction_state.dart';
import 'package:transaction_repository/transaction_repository.dart';

class UpdateTransactionBloc
    extends Bloc<UpdateTransactionEvent, UpdateTransactionState> {
  final TransactionRepository _transactionRepository;

  UpdateTransactionBloc({required TransactionRepository transactionRepository})
    : _transactionRepository = transactionRepository,
      super(UpdateTransactionInitial()) {
    on<UpdateTransaction>((event, emit) async {
      emit(UpdateTransactionLoading());
      try {
        Transaction transaction = await _transactionRepository
            .updateTransaction(event.transaction);
        emit(UpdateTransactionSuccess(transaction));
      } catch (e) {
        emit(UpdateTransactionFailure());
      }
    });
  }
}
