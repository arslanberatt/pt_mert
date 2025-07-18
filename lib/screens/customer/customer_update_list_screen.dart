import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pt_mert/blocs/get_customer_bloc/get_customer_bloc.dart';
import 'package:pt_mert/components/classic_appbar.dart';
import 'package:pt_mert/screens/customer/update_customer_screen.dart';
import 'package:pt_mert/screens/customer/widgets/customer_add_icon.dart';

class CustomerUpdateListScreen extends StatefulWidget {
  const CustomerUpdateListScreen({super.key});

  @override
  State<CustomerUpdateListScreen> createState() =>
      _CustomerUpdateListScreenState();
}

class _CustomerUpdateListScreenState extends State<CustomerUpdateListScreen> {
  String _searchQuery = '';

  String formatDate(DateTime date) {
    final formatter = DateFormat("d MMMM y", "tr_TR");
    return formatter.format(date);
  }

  @override
  void initState() {
    super.initState();
    context.read<GetCustomerBloc>().add(GetCustomer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClassicAppBar(action: CustomerAddWidget()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) =>
                  setState(() => _searchQuery = value.toLowerCase().trim()),
              decoration: InputDecoration(
                hintText: 'Müşteri adıyla ara...',
                prefixIcon: Icon(Icons.search),
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
                  return const Center(child: Text("Müşteriler yüklenemedi."));
                } else if (state is GetCustomerSuccess) {
                  final allCustomers = state.customers;

                  final filteredCustomers = allCustomers.where((c) {
                    return c.name.toLowerCase().startsWith(_searchQuery);
                  }).toList();

                  if (filteredCustomers.isEmpty) {
                    return const Center(
                      child: Text("Eşleşen müşteri bulunamadı."),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final student = filteredCustomers[index];
                      return GestureDetector(
                        onTap: () async {
                          final updatedCustomer = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  UpdateCustomerScreen(customer: student),
                            ),
                          );

                          if (updatedCustomer != null) {
                            await FirebaseCustomerRepository().updateCustomer(
                              updatedCustomer,
                            );
                            context.read<GetCustomerBloc>().add(GetCustomer());
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.person_outline, size: 24),
                            ),
                            title: Text(student.name),
                            subtitle: Text(
                              "Başlangıç: ${formatDate(student.createdAt)}",
                            ),
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
