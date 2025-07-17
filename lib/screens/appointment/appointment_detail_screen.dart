import 'package:appointment_repository/appointment_repository.dart';
import 'package:appointment_repository/src/models/appointment_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pt_mert/components/classic_appbar.dart';
import 'package:pt_mert/components/date_input.dart';
import 'package:pt_mert/components/section_tile.dart';
import 'package:pt_mert/components/section_title.dart';
import 'package:pt_mert/screens/appointment/controllers/appointment_detail_controller.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final Appointment appointment;
  const AppointmentDetailScreen({super.key, required this.appointment});

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  late Appointment _appointment;
  late AppointmentDetailController _controller;

  @override
  void initState() {
    super.initState();
    _appointment = widget.appointment;
    _controller = AppointmentDetailController(
      appointmentRepository: FirebaseAppointmentRepository(),
    );
  }

  Future<void> _updateAppointmentPrice() async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Yeni Tutar"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: "Örn: 150.0"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text("Kaydet"),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      final parsed = double.tryParse(result.replaceAll(',', '.'));
      if (parsed != null) {
        final updated = await _controller.updatePrice(_appointment, parsed);
        setState(() {
          _appointment = updated;
        });
        Navigator.pop(context, updated);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Geçerli bir sayı giriniz.")),
        );
      }
    }
  }

  Future<void> _updateAppointmentStatus(AppointmentStatus status) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Emin misiniz?"),
        content: Text(
          status == AppointmentStatus.completed
              ? "Bu randevuyu tamamlandı olarak işaretlemek istiyor musunuz?"
              : "Bu randevuyu iptal etmek istiyor musunuz?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Hayır"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Evet"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final updated = await _controller.updateStatus(_appointment, status);
      setState(() {
        _appointment = updated;
      });
      Navigator.pop(context, updated);
    }
  }

  void _handleDateTimeChanged(DateTime newDateTime) async {
    if (_appointment.status != AppointmentStatus.pending) return;

    final updated = await _controller.updateDate(_appointment, newDateTime);
    setState(() {
      _appointment = updated;
    });
    Navigator.pop(context, updated);
  }

  @override
  Widget build(BuildContext context) {
    final customer = _appointment.customer;
    final isEditable = _appointment.status == AppointmentStatus.pending;

    return Scaffold(
      appBar: ClassicAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: "Müşteri Bilgileri"),
            const SizedBox(height: 8),
            SectionTile(
              icon: Icons.person_outline,
              title: customer.name,
              subtitle: customer.phone,
            ),
            SectionTile(
              title: "Üyelik Durumu",
              subtitle: customer.trainingCount == 0
                  ? "Günlük Müşteri"
                  : customer.trainingCount == 1
                  ? "Son Antrenman"
                  : "${customer.trainingCount} Antrenman",
              icon: Icons.fitness_center_outlined,
            ),
            const SizedBox(height: 8),
            SectionTitle(title: "Randevu Durumu"),
            const SizedBox(height: 8),

            /// Tarih
            isEditable
                ? CustomDateTimePicker(
                    title: "Randevu Tarihi",
                    initialDate: _appointment.date,
                    onDateTimeSelected: _handleDateTimeChanged,
                  )
                : SectionTile(
                    icon: Icons.calendar_today,
                    title: "Tarih",
                    subtitle: DateFormat(
                      'd MMMM y - HH:mm',
                      'tr_TR',
                    ).format(_appointment.date),
                  ),

            /// Durum
            SectionTile(
              icon: Icons.check_circle,
              title: "Durum",
              subtitle: _appointment.status.value,
            ),

            /// Tutar
            SectionTile(
              icon: Icons.attach_money,
              title: "Tutar",
              subtitle: _appointment.price != null
                  ? "${_appointment.price!.toStringAsFixed(2)} ₺"
                  : "Belirtilmemiş",
              onTap: isEditable ? _updateAppointmentPrice : null,
            ),

            /// Butonlar sadece pending'de çıkacak
            if (isEditable) ...[
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          _updateAppointmentStatus(AppointmentStatus.cancelled),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black),
                      ),
                      child: const Text("İptal Et"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          _updateAppointmentStatus(AppointmentStatus.completed),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text("Tamamlandı"),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
