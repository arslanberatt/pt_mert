import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pt_mert/screens/home_screen.dart';
import 'package:pt_mert/screens/welcome_screen.dart';
import 'package:pt_mert/utils/theme/theme.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PT Mert',
      theme: CustomTheme.lightTheme,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
        if(state.status == AuthenticationStatus.authenticated){
          return HomeScreen();
        }else{
          return WelcomeScreen();
        }
      },)
    );
  }
}
