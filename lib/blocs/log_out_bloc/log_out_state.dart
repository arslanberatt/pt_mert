part of 'log_out_bloc.dart';

sealed class LogOutState extends Equatable {
  const LogOutState();

  @override
  List<Object> get props => [];
}

final class LogOutInitial extends LogOutState {}

final class LogOutSuccess extends LogOutState {}

final class LogOutFailure extends LogOutState {
  final String? message;

  const LogOutFailure({this.message});
}

final class LogOutProcess extends LogOutState {}
