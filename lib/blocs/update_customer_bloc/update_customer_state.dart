part of 'update_customer_bloc.dart';

sealed class UpdateCustomerState extends Equatable {
  const UpdateCustomerState();

  @override
  List<Object> get props => [];
}

final class UpdateCustomerInitial extends UpdateCustomerState {}

final class UpdateCustomerFailure extends UpdateCustomerState {}

final class UpdateCustomerLoading extends UpdateCustomerState {}

final class UpdateCustomerSuccess extends UpdateCustomerState {
  final Customer customer;
  const UpdateCustomerSuccess(this.customer);
}
