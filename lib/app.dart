import 'package:appointment_repository/appointment_repository.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/app_view.dart';
import 'package:pt_mert/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pt_mert/blocs/create_appointment_bloc/create_appointment_bloc.dart';
import 'package:pt_mert/blocs/get_customer_bloc/get_customer_bloc.dart';
import 'package:pt_mert/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pt_mert/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MainApp extends StatelessWidget {
  final UserRepository userRepository;
  final AppointmentRepository appointmentRepository;
  final CustomerRepository customerRepository;

  const MainApp(
    this.userRepository,
    this.appointmentRepository,
    this.customerRepository, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      // Repository'leri burada sağlıyoruz
      providers: [
        RepositoryProvider<UserRepository>.value(value: userRepository),
        RepositoryProvider<AppointmentRepository>.value(
          value: appointmentRepository,
        ),
        RepositoryProvider<CustomerRepository>.value(value: customerRepository),
      ],
      child: MultiBlocProvider(
        // BLoC'ları burada sağlıyoruz
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              myUserRepository: context
                  .read<UserRepository>(), // UserRepository'yi context'ten oku
            ),
          ),
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
              userRepository: context
                  .read<UserRepository>(), // UserRepository'yi context'ten oku
            ),
          ),
          BlocProvider<CreateAppointmentBloc>(
            create: (context) => CreateAppointmentBloc(
              appointmentRepository: context
                  .read<
                    AppointmentRepository
                  >(), // AppointmentRepository'yi context'ten oku
            ),
          ),
          BlocProvider<GetCustomerBloc>(
            create: (context) =>
                GetCustomerBloc(
                  customerRepository: context
                      .read<
                        CustomerRepository
                      >(), // CustomerRepository'yi context'ten oku
                )..add(
                  GetCustomer(), // Tüm müşterileri getiren olay
                ),
          ),
          BlocProvider<MyUserBloc>(
            create: (context) =>
                MyUserBloc(
                  myUserRepository: context
                      .read<
                        UserRepository
                      >(), // UserRepository'yi context'ten oku
                )..add(
                  // AuthenticationBloc'un state'i dinlenmeden önce initialize edilmiş olmalı
                  // Bu kısım, MyUserBloc'un Auth Bloc'a bağımlılığı nedeniyle dikkatli olmalı.
                  // Genellikle MyUserBloc, AuthenticationBloc'tan sonra ve AuthenticationBloc'un durumuna göre tetiklenir.
                  // Bu ilk yüklemede user null olabilir, bu yüzden bir kontrol ekleyelim.
                  context.read<AuthenticationBloc>().state.user != null
                      ? GetMyUser(
                          myUserId: context
                              .read<AuthenticationBloc>()
                              .state
                              .user!
                              .uid,
                        )
                      : GetMyUser(
                          myUserId: '',
                        ), // Boş bir ID veya başka bir varsayılan değer
                ),
          ),
        ],
        child: const MyAppView(),
      ),
    );
  }
}
