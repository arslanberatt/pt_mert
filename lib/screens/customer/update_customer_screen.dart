import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pt_mert/blocs/get_customer_bloc/get_customer_bloc.dart';
import 'package:pt_mert/components/classic_appbar.dart';
import 'package:pt_mert/components/date_input.dart';
import 'package:pt_mert/components/text_field.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:pt_mert/utils/constants/sizes.dart';

class UpdateCustomerScreen extends StatefulWidget {
  final Customer customer;

  const UpdateCustomerScreen({super.key, required this.customer});

  @override
  State<UpdateCustomerScreen> createState() => _UpdateCustomerScreenState();
}

class _UpdateCustomerScreenState extends State<UpdateCustomerScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _noteController;
  late TextEditingController _trainingCountController;
  DateTime? _selectedDate;
  bool? _isActive;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer.name);
    _phoneController = TextEditingController(text: widget.customer.phone);
    _noteController = TextEditingController(text: widget.customer.note ?? '');
    _trainingCountController = TextEditingController(
      text: widget.customer.trainingCount.toString(),
    );
    _selectedDate = widget.customer.lastTrainingDate;
    _isActive = widget.customer.isActive;
  }

  void pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
      locale: const Locale('tr', 'TR'),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void saveUpdatedCustomer() {
    final updatedCustomer = widget.customer.copyWith(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      note: _noteController.text.trim(),
      trainingCount: int.tryParse(_trainingCountController.text.trim()) ?? 0,
      lastTrainingDate: _selectedDate,
      isActive: _isActive,
    );
    Navigator.pop(context, updatedCustomer);
    context.read<GetCustomerBloc>().add(GetCustomer());
  }

  String formatDate(DateTime? date) {
    if (date == null) return "Tarih seçilmedi";
    return DateFormat("d MMMM y", "tr_TR").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClassicAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            MyTextField(
              controller: _nameController,
              label: Text('Ad Soyad'),
              obscureText: false,
              keyboardType: TextInputType.name,
            ),
            MyTextField(
              controller: _phoneController,
              label: Text('Telefon'),
              obscureText: false,
              keyboardType: TextInputType.phone,
            ),

            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Not'),
              maxLines: 3,
            ),
            const SizedBox(height: AppSizes.spacingM),
            MyTextField(
              controller: _trainingCountController,
              label: Text('Ders Sayısı'),
              obscureText: false,
              keyboardType: TextInputType.number,
            ),
            CustomDateTimePicker(
              title: 'Son Antrenman',
              initialDate: _selectedDate,
              onDateTimeSelected: (selected) {
                setState(() => _selectedDate = selected);
              },
            ),
            const SizedBox(height: AppSizes.spacingM),
            SwitchListTile(
              title: const Text("Aktif Üyelik"),
              value: _isActive!,
              onChanged: (value) => setState(() => _isActive = value),
              activeColor: AppColors.blackTextColor,
              activeTrackColor: AppColors.hardGrayTextColor,
              inactiveThumbColor: AppColors.blackTextColor,
              inactiveTrackColor: AppColors.inputFieldColor,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveUpdatedCustomer,
                child: const Text("Kaydet"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
