import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/app_view.dart';
import 'package:pt_mert/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pt_mert/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pt_mert/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MainApp extends StatelessWidget {
  final UserRepository userRepository;
  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(myUserRepository: userRepository),
        ),
        BlocProvider<SignUpBloc>(
          create: (_) => SignUpBloc(userRepository: userRepository),
        ),
        BlocProvider(
          create: (context) =>
              MyUserBloc(
                myUserRepository: context
                    .read<AuthenticationBloc>()
                    .userRepository,
              )..add(
                GetMyUser(
                  myUserId: context.read<AuthenticationBloc>().state.user!.uid,
                ),
              ),
        ),
      ],
      child: const MyAppView(),
    );
  }
}
