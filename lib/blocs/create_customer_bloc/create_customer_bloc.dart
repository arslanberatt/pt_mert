import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';

part 'create_customer_event.dart';
part 'create_customer_state.dart';

class CreateCustomerBloc
    extends Bloc<CreateCustomerEvent, CreateCustomerState> {
  CustomerRepository _customerRepository;

  CreateCustomerBloc({required CustomerRepository customerRepository})
    : _customerRepository = customerRepository,
      super(CreateCustomerInitial()) {
    on<CreateCustomer>((event, emit) async {
      emit(CreateCustomerLoading());
      try {
        Customer customer = await _customerRepository.createCustomer(
          event.customer,
        );
        emit(CreateCustomerSuccess(customer));
      } catch (e) {
        emit(CreateCustomerFailure());
      }
    });
  }
}
