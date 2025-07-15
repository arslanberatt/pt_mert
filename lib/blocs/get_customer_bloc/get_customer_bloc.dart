import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_customer_event.dart';
part 'get_customer_state.dart';

class GetCustomerBloc extends Bloc<GetCustomerEvent, GetCustomerState> {
  CustomerRepository _customerRepository;
  GetCustomerBloc({required CustomerRepository customerRepository})
    : _customerRepository = customerRepository,
      super(GetCustomerInitial()) {
    on<GetCustomer>((event, emit) async {
      emit(GetCustomerLoading());
      try {
        List<Customer> customers = await _customerRepository.getCustomer();
        emit(GetCustomerSuccess(customers));
      } catch (e) {
        emit(GetCustomerFailure());
      }
    });
  }
}
