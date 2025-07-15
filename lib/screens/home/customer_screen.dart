import 'package:flutter/material.dart';
import 'package:pt_mert/components/date_input.dart';
import 'package:pt_mert/components/text_field.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final trainingCountController = TextEditingController();
  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Öğrenci Kaydı"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Ad Soyad
            MyTextField(
              controller: nameController,
              hintText: "Ad Soyad",
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.person_outline),
            ),
            const SizedBox(height: 16),

            /// Telefon
            MyTextField(
              controller: phoneController,
              hintText: "Telefon numarası",
              obscureText: false,
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone),
            ),
            const SizedBox(height: 16),

            /// Antrenman Sayısı
            MyTextField(
              controller: trainingCountController,
              hintText: "Antrenman Sayısı (örn: 5)",
              obscureText: false,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.fitness_center),
            ),
            const SizedBox(height: 16),

            /// Notlar
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

            const SizedBox(height: 24),

            /// Kaydet Butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Modelin oluşturulup veritabanına kaydedilmesi
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
