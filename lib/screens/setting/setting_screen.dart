import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/create_customer_bloc/create_customer_bloc.dart';
import 'package:pt_mert/blocs/get_customer_bloc/get_customer_bloc.dart';
import 'package:pt_mert/components/appbar.dart';
import 'package:pt_mert/screens/customer/customer_update_list_screen.dart';
import 'package:pt_mert/screens/home/customer_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          SizedBox(height: 24),
          _SectionTitle(title: "Uygulama Yönetimi"),
          _SettingsTile(
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
          _SettingsTile(
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
          _SectionTitle(title: "Hesap Yönetimi"),
          _SettingsTile(
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
          _SettingsTile(
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
          _SettingsTile(
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
          _SectionTitle(title: "Destek & Yardım"),
          _SettingsTile(
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
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
