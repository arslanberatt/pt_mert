import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/create_transaction_bloc/create_transaction_bloc.dart';
import 'package:pt_mert/blocs/create_transaction_bloc/create_transaction_event.dart';
import 'package:pt_mert/blocs/create_transaction_bloc/create_transaction_state.dart';
import 'package:pt_mert/blocs/get_transaction_bloc/get_transaction_bloc.dart';
import 'package:pt_mert/components/classic_appbar.dart';
import 'package:pt_mert/components/date_input.dart';
import 'package:pt_mert/components/text_field.dart';
import 'package:pt_mert/screens/transaction/widgets/transaction_type_toggle.dart';
import 'package:transaction_repository/transaction_repository.dart';
import 'package:transaction_repository/src/models/transaction_type.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  TransactionType _selectedType = TransactionType.income;
  DateTime _selectedDate = DateTime.now();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final transaction = Transaction(
      transactionId: '', // Bloc veya repo içinde atanacak
      title: _titleController.text.trim(),
      amount: double.tryParse(_amountController.text.trim()) ?? 0,
      type: _selectedType,
      createdAt: _selectedDate,
      isActive: true,
    );

    context.read<CreateTransactionBloc>().add(CreateTransaction(transaction));
    context.read<GetTransactionBloc>().add(GetTransaction());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTransactionBloc, CreateTransactionState>(
      listener: (context, state) {
        if (state is CreateTransactionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("İşlem başarıyla eklendi")),
          );
          Navigator.pop(context);
        } else if (state is CreateTransactionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Bir hata oluştu, tekrar deneyin.")),
          );
        }
      },
      child: Scaffold(
        appBar: ClassicAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TransactionTypeToggle(
                  selectedType: _selectedType,
                  onChanged: (val) {
                    setState(() {
                      _selectedType = val;
                    });
                  },
                ),
                const SizedBox(height: 18),
                MyTextField(
                  controller: _titleController,
                  label: const Text("Sebep"),
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.title),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Başlık boş olamaz";
                    }
                    return null;
                  },
                ),
                MyTextField(
                  controller: _amountController,
                  label: const Text("Fiyat"),
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.attach_money),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final parsed = double.tryParse(value);
                      if (parsed == null || parsed < 0) {
                        return "Geçerli bir fiyat girin";
                      }
                    }
                    return null;
                  },
                ),
                CustomDateTimePicker(
                  initialDate: _selectedDate,
                  title: "Tarih Seç (Opsiyonel)",
                  onDateTimeSelected: (DateTime value) {
                    _selectedDate = value;
                  },
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
