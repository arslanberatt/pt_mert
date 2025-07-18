import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/get_customer_bloc/get_customer_bloc.dart';
import 'package:pt_mert/screens/customer/customer_update_list_screen.dart';

class CustomerListWidget extends StatelessWidget {
  const CustomerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => GetCustomerBloc(
                customerRepository: FirebaseCustomerRepository(),
              )..add(GetCustomer()),
              child: CustomerUpdateListScreen(),
            ),
          ),
        );
      },
      icon: const Icon(Icons.person_add_disabled, color: Colors.black87),
    );
  }
}
