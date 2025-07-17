import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/create_customer_bloc/create_customer_bloc.dart';
import 'package:pt_mert/blocs/get_customer_bloc/get_customer_bloc.dart';
import 'package:pt_mert/components/appbar.dart';
import 'package:pt_mert/components/section_tile.dart';
import 'package:pt_mert/components/section_title.dart';
import 'package:pt_mert/screens/customer/customer_update_list_screen.dart';
import 'package:pt_mert/screens/home/customer_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SizedBox(height: 24),
            SectionTitle(title: "Uygulama Yönetimi"),
            SizedBox(height: 12),
            SectionTile(
              icon: Icons.person_outline,
              title: "Müşteri Bilgileri",
              subtitle: "Müşteri durumunu ve bilgilerini yönet",
              onTap: () {
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
            ),
            SectionTile(
              icon: Icons.person_outline,
              title: "Kasa İşlemleri",
              subtitle: "Kasa işlemlerini ve bilgilerini yönet",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        BlocProvider<CreateCustomerBloc>(
                          create: (context) => CreateCustomerBloc(
                            customerRepository: FirebaseCustomerRepository(),
                          ),
                          child: CustomerScreen(),
                        ),
                  ),
                );
              },
            ),
            SizedBox(height: 12),
            SectionTitle(title: "Hesap Yönetimi"),
            SizedBox(height: 12),
            SectionTile(
              icon: Icons.person_outline,
              title: "Hesap Bilgileri",
              subtitle: "Hesap durumunu ve bilgilerini yönet",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        BlocProvider<CreateCustomerBloc>(
                          create: (context) => CreateCustomerBloc(
                            customerRepository: FirebaseCustomerRepository(),
                          ),
                          child: CustomerScreen(),
                        ),
                  ),
                );
              },
            ),
            SectionTile(
              icon: Icons.lock_outline,
              title: "Parola",
              subtitle: "Parolanı değiştir",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        BlocProvider<CreateCustomerBloc>(
                          create: (context) => CreateCustomerBloc(
                            customerRepository: FirebaseCustomerRepository(),
                          ),
                          child: CustomerScreen(),
                        ),
                  ),
                );
              },
            ),
            SectionTile(
              icon: Icons.notifications_none,
              title: "Bildirimler",
              subtitle: "Bildirim ayarlarınızı yönetin",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        BlocProvider<CreateCustomerBloc>(
                          create: (context) => CreateCustomerBloc(
                            customerRepository: FirebaseCustomerRepository(),
                          ),
                          child: CustomerScreen(),
                        ),
                  ),
                );
              },
            ),
            SizedBox(height: 12),
            SectionTitle(title: "Destek & Yardım"),
            SizedBox(height: 12),
            SectionTile(
              icon: Icons.support_agent,
              title: "Destek İste",
              subtitle: "Destek ile iletşime geç",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        BlocProvider<CreateCustomerBloc>(
                          create: (context) => CreateCustomerBloc(
                            customerRepository: FirebaseCustomerRepository(),
                          ),
                          child: CustomerScreen(),
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
