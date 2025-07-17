import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:pt_mert/blocs/create_customer_bloc/create_customer_bloc.dart';
import 'package:pt_mert/blocs/get_customer_bloc/get_customer_bloc.dart';
import 'package:pt_mert/components/classic_appbar.dart';
import 'package:pt_mert/components/text_field.dart';
import 'package:pt_mert/utils/constants/colors.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _trainingCountController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isActive = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final customer = Customer.empty.copyWith(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        trainingCount: int.parse(_trainingCountController.text.trim()),
        note: _notesController.text.trim(),
        isActive: _isActive,
      );
      context.read<CreateCustomerBloc>().add(CreateCustomer(customer));
      context.read<GetCustomerBloc>().add(GetCustomer());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCustomerBloc, CreateCustomerState>(
      listener: (context, state) {
        // Güzel Bi Get.SnackBar getirilmesi lazım
        if (state is CreateCustomerSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Öğrenci başarıyla kaydedildi!")),
          );
          Navigator.pop(context);
        } else if (state is CreateCustomerFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Bir hata oluştu, tekrar deneyin.")),
          );
        }
      },
      child: Scaffold(
        appBar: ClassicAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                MyTextField(
                  controller: _nameController,
                  label: Text('Ad Soyad'),
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (value) {
                    if (value == null || value.trim().length < 3) {
                      return "Ad en az 3 karakter olmalı";
                    }
                    return null;
                  },
                ),
                MyTextField(
                  controller: _phoneController,
                  label: Text('Telefon'),
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone),
                  validator: (value) {
                    if (value == null || value.trim().length < 10) {
                      return "Geçerli bir telefon numarası girin";
                    }
                    return null;
                  },
                ),
                MyTextField(
                  controller: _trainingCountController,
                  label: Text('Antrenman Sayısı'),
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.fitness_center),
                  validator: (value) {
                    final parsed = int.tryParse(value ?? '');
                    if (parsed == null || parsed < 0) {
                      return "Geçerli bir sayı girin";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _notesController,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: "Notlar"),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text("Aktif Üyelik"),
                  value: _isActive,
                  onChanged: (val) => setState(() => _isActive = val),
                  activeColor: AppColors.blackTextColor,
                  activeTrackColor: AppColors.hardGrayTextColor,
                  inactiveThumbColor: AppColors.blackTextColor,
                  inactiveTrackColor: AppColors.inputFieldColor,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text("Kaydet"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
