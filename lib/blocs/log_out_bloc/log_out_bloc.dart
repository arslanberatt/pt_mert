import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'log_out_event.dart';
part 'log_out_state.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> {
  final UserRepository _userRepository;
  LogOutBloc({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(LogOutInitial()) {
    on<LogOutEvent>((event, emit) async {
      emit(LogOutProcess());
      try {
        await _userRepository.logOut();
        emit(LogOutFailure());
      } catch (e) {
        log("[Logout Error] ${e.toString()}");
      }
    });
  }
}
