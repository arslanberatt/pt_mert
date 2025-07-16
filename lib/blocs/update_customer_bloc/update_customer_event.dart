part of 'update_customer_bloc.dart';

sealed class UpdateCustomerEvent extends Equatable {
  const UpdateCustomerEvent();

  @override
  List<Object> get props => [];
}

class UpdateCustomer extends UpdateCustomerEvent {
  final Customer customer;

  const UpdateCustomer(this.customer);
}
