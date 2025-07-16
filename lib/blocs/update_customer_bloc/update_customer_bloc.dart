import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';

part 'update_customer_event.dart';
part 'update_customer_state.dart';

class UpdateCustomerBloc
    extends Bloc<UpdateCustomerEvent, UpdateCustomerState> {
  final CustomerRepository _customerRepository;

  UpdateCustomerBloc({required CustomerRepository customerRepository})
    : _customerRepository = customerRepository,
      super(UpdateCustomerInitial()) {
    on<UpdateCustomer>((event, emit) async {
      emit(UpdateCustomerLoading());
      try {
        Customer customer = await _customerRepository.updateCustomer(
          event.customer,
        );
        emit(UpdateCustomerSuccess(customer));
      } catch (e) {
        emit(UpdateCustomerFailure());
      }
    });
  }
}
