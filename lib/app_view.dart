import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pt_mert/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pt_mert/screens/home/home_screen.dart';
import 'package:pt_mert/screens/authentication/sign_in_screen.dart';
import 'package:pt_mert/utils/theme/theme.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PT Mert',
      theme: CustomTheme.lightTheme,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(
                userRepository: context
                    .read<AuthenticationBloc>()
                    .userRepository,
              ),
              child: const HomeScreen(),
            );
            // return HomeScreen();
          } else {
            return BlocProvider(
              create: (context) => SignInBloc(
                userRepository: context
                    .read<AuthenticationBloc>()
                    .userRepository,
              ),
              child: const SignInScreen(),
            );
            // return SignInScreen();
          }
        },
      ),
    );
  }
}
