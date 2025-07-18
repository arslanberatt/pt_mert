import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/create_customer_bloc/create_customer_bloc.dart';
import 'package:pt_mert/screens/customer/customer_screen.dart';

class CustomerAddWidget extends StatelessWidget {
  const CustomerAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => BlocProvider<CreateCustomerBloc>(
              create: (context) => CreateCustomerBloc(
                customerRepository: FirebaseCustomerRepository(),
              ),
              child: CustomerScreen(),
            ),
          ),
        );
      },
      icon: const Icon(Icons.person_add_rounded, color: Colors.black87),
    );
  }
}
