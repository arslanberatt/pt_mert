import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //saat ve şarjı siyah gömesini sağlıyor   ******
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text('Home', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
