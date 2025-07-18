import 'package:appointment_repository/appointment_repository.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/app_view.dart';
import 'package:pt_mert/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pt_mert/blocs/create_transaction_bloc/create_transaction_bloc.dart';
import 'package:pt_mert/blocs/get_appointment_bloc/get_appointment_bloc.dart';
import 'package:pt_mert/blocs/get_customer_bloc/get_customer_bloc.dart';
import 'package:pt_mert/blocs/get_transaction_bloc/get_transaction_bloc.dart';
import 'package:pt_mert/blocs/log_out_bloc/log_out_bloc.dart';
import 'package:pt_mert/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pt_mert/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:transaction_repository/transaction_repository.dart';
import 'package:user_repository/user_repository.dart';

class MainApp extends StatelessWidget {
  final UserRepository userRepository;
  final AppointmentRepository appointmentRepository;
  final CustomerRepository customerRepository;
  final TransactionRepository transactionRepository;

  const MainApp(
    this.userRepository,
    this.appointmentRepository,
    this.customerRepository,
    this.transactionRepository, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(value: userRepository),
        RepositoryProvider<AppointmentRepository>.value(
          value: appointmentRepository,
        ),
        RepositoryProvider<CustomerRepository>.value(value: customerRepository),
        RepositoryProvider<TransactionRepository>.value(
          value: transactionRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              myUserRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<SignUpBloc>(
            create: (context) =>
                SignUpBloc(userRepository: context.read<UserRepository>()),
          ),
          BlocProvider<GetAppointmentBloc>(
            create: (context) => GetAppointmentBloc(
              appointmentRepository: context.read<AppointmentRepository>(),
              customerRepository: customerRepository,
            ),
          ),
          BlocProvider<GetCustomerBloc>(
            create: (context) => GetCustomerBloc(
              customerRepository: context.read<CustomerRepository>(),
            )..add(GetCustomer()),
          ),
          BlocProvider<GetTransactionBloc>(
            create: (context) => GetTransactionBloc(
              transactionRepository: context.read<TransactionRepository>(),
            )..add(GetTransaction()),
          ),
          BlocProvider<LogOutBloc>(
            create: (context) =>
                LogOutBloc(userRepository: context.read<UserRepository>()),
          ),

          BlocProvider<CreateTransactionBloc>(
            create: (context) => CreateTransactionBloc(
              transactionRepository: context.read<TransactionRepository>(),
            ),
          ),
          BlocProvider<MyUserBloc>(
            create: (context) =>
                MyUserBloc(myUserRepository: context.read<UserRepository>())
                  ..add(
                    context.read<AuthenticationBloc>().state.user != null
                        ? GetMyUser(
                            myUserId: context
                                .read<AuthenticationBloc>()
                                .state
                                .user!
                                .uid,
                          )
                        : GetMyUser(myUserId: ''),
                  ),
          ),
        ],
        child: const MyAppView(),
      ),
    );
  }
}
