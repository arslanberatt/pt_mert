import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/create_transaction_bloc/create_transaction_bloc.dart';
import 'package:pt_mert/screens/transaction/create_transaction_screen.dart';
import 'package:transaction_repository/transaction_repository.dart';

class TransactionAddWidget extends StatelessWidget {
  const TransactionAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                BlocProvider<CreateTransactionBloc>(
                  create: (context) => CreateTransactionBloc(
                    transactionRepository: FirebaseTransactionRepository(),
                  ),
                  child: CreateTransactionScreen(),
                ),
          ),
        );
      },
      icon: const Icon(Icons.add_circle_rounded, color: Colors.black87),
    );
  }
}
