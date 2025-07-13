import 'package:flutter/material.dart';
import 'package:pt_mert/components/date_input.dart';
import 'package:pt_mert/components/text_field.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final trainingCountController = TextEditingController();
    final notesController = TextEditingController();
    final paymentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Öğrenci Kaydı"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MyTextField(
              controller: nameController,
              hintText: "Adınızı giriniz",
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.person_outline),
            ),
            const SizedBox(height: 16),
            MyTextField(
              controller: phoneController,
              hintText: "Telefon numarası",
              obscureText: false,
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone),
            ),
            const SizedBox(height: 16),
            MyTextField(
              controller: trainingCountController,
              hintText: "Örn: 5",
              obscureText: false,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.fitness_center),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Notlar",
                hintText: "Örn: Dizi sakat, dikkat edilmeli",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            MyTextField(
              controller: paymentController,
              hintText: "Toplam Ödeme (₺)",
              obscureText: false,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.attach_money),
            ),
            const SizedBox(height: 16),
            CustomDateTimePicker(onDateTimeSelected: (DateTime selected) {}),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Kaydet
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Kaydet"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
