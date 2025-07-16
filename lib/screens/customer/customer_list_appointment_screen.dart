import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pt_mert/blocs/get_customer_bloc/get_customer_bloc.dart';
import 'package:pt_mert/screens/appointment/appointment_screen.dart';
import 'package:pt_mert/screens/customer/update_customer.dart';
import 'package:pt_mert/screens/customer/widgets/customer_add.dart';

class CustomerListAppointmentScreen extends StatefulWidget {
  const CustomerListAppointmentScreen({super.key});

  @override
  State<CustomerListAppointmentScreen> createState() =>
      _CustomerListAppointmentScreenState();
}

class _CustomerListAppointmentScreenState
    extends State<CustomerListAppointmentScreen> {
  String _searchQuery = '';

  String formatDate(DateTime date) {
    final formatter = DateFormat("d MMMM y", "tr_TR"); // Türkçe tarih formatı
    return formatter.format(date);
  }

  @override
  void initState() {
    super.initState();
    context.read<GetCustomerBloc>().add(GetCustomer()); // Müşterileri yükle
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PT Mert",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        actions: [CustomerAddWidget()],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) =>
                  setState(() => _searchQuery = value.toLowerCase().trim()),
              decoration: InputDecoration(
                hintText: 'Müşteri adıyla ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<GetCustomerBloc, GetCustomerState>(
              builder: (context, state) {
                if (state is GetCustomerLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetCustomerFailure) {
                  return Center(child: Text("Müşteriler yüklenemedi"));
                } else if (state is GetCustomerSuccess) {
                  final activeCustomers = state.customers
                      .where((c) => c.isActive == true)
                      .toList();
                  final filteredCustomers = activeCustomers.where((c) {
                    return c.name.toLowerCase().contains(_searchQuery);
                  }).toList();

                  if (filteredCustomers.isEmpty) {
                    return const Center(
                      child: Text("Eşleşen aktif müşteri bulunamadı."),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = filteredCustomers[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AppointmentScreen(initialCustomer: customer),
                            ),
                          );
                        },
                        onLongPress: () async {
                          final updatedCustomer = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  UpdateCustomerScreen(customer: customer),
                            ),
                          );

                          if (updatedCustomer != null) {
                            context.read<GetCustomerBloc>().add(GetCustomer());
                          }
                        },
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.person_outline, size: 24),
                          ),
                          title: Text(customer.name),
                          subtitle: Text(
                            "Başlangıç: ${formatDate(customer.createdAt)}",
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
