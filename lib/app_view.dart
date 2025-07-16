import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pt_mert/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pt_mert/screens/authentication/sign_in_screen.dart';
import 'package:pt_mert/screens/main_navigation_screen.dart';
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
            return const MainNavigationPage();
          } else {
            return const SignInScreen();
          }
        },
      ),
      // home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      //   builder: (context, state) {
      //     if (state.status == AuthenticationStatus.authenticated) {
      //       return BlocProvider(
      //         create: (context) => SignInBloc(
      //           userRepository: context
      //               .read<AuthenticationBloc>()
      //               .userRepository,
      //         ),
      //         child: const HomeScreen(),
      //       );
      //     } else {
      //       return BlocProvider(
      //         create: (context) => SignInBloc(
      //           userRepository: context
      //               .read<AuthenticationBloc>()
      //               .userRepository,
      //         ),
      //         child: const SignInScreen(),
      //       );
      //     }
      //   },
      // ),
      locale: const Locale('tr', 'TR'),
      supportedLocales: const [Locale('tr', 'TR'), Locale('en', 'US')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
