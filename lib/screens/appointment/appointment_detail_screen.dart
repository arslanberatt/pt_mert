import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pt_mert/components/classic_appbar.dart';
import 'package:pt_mert/components/date_input.dart';
import 'package:pt_mert/components/section_tile.dart';
import 'package:pt_mert/components/section_title.dart';
import 'package:appointment_repository/appointment_repository.dart';
import 'package:appointment_repository/src/models/appointment_status.dart';
import 'package:pt_mert/cubits/apointment/update_appointment_cubit.dart';
import 'package:pt_mert/cubits/apointment/update_appointment_state.dart';

class AppointmentDetailScreen extends StatelessWidget {
  const AppointmentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateAppointmentCubit, UpdateAppointmentState>(
      listener: (context, state) {
        if (!state.isLoading) {
          Navigator.pop(context, state.appointment);
        }
      },
      builder: (context, state) {
        final appointment = state.appointment;
        final customer = appointment.customer;
        final isEditable = appointment.status == AppointmentStatus.pending;

        return Scaffold(
          appBar: ClassicAppBar(),
          body: Stack(
            children: [
              Padding(
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
                      icon: Icons.fitness_center_outlined,
                      title: "Üyelik Durumu",
                      subtitle: customer.trainingCount == 0
                          ? "Günlük Müşteri"
                          : customer.trainingCount == 1
                          ? "Son Antrenman"
                          : "${customer.trainingCount} Antrenman",
                    ),
                    const SizedBox(height: 8),
                    SectionTitle(title: "Randevu Durumu"),
                    const SizedBox(height: 8),

                    // Tarih
                    isEditable
                        ? CustomDateTimePicker(
                            title: "Randevu Tarihi",
                            initialDate: appointment.date,
                            onDateTimeSelected: (newDate) {
                              context.read<UpdateAppointmentCubit>().updateDate(
                                newDate,
                              );
                            },
                          )
                        : SectionTile(
                            icon: Icons.calendar_today,
                            title: "Tarih",
                            subtitle: DateFormat(
                              'd MMMM y - HH:mm',
                              'tr_TR',
                            ).format(appointment.date),
                          ),

                    SectionTile(
                      icon: Icons.check_circle,
                      title: "Durum",
                      subtitle: appointment.status.value,
                    ),
                    SectionTile(
                      icon: Icons.attach_money,
                      title: "Tutar",
                      subtitle: appointment.price != null
                          ? "${appointment.price!.toStringAsFixed(2)} ₺"
                          : "Belirtilmemiş",
                      onTap: isEditable
                          ? () => _showPriceDialog(context, appointment)
                          : null,
                    ),

                    if (isEditable) ...[
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<UpdateAppointmentCubit>()
                                    .updateStatus(AppointmentStatus.cancelled);
                              },
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
                              onPressed: () {
                                context
                                    .read<UpdateAppointmentCubit>()
                                    .updateStatus(AppointmentStatus.completed);
                              },
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

              if (state.isLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }

  void _showPriceDialog(BuildContext context, Appointment appointment) async {
    final controller = TextEditingController(
      text: appointment.price?.toStringAsFixed(2) ?? '',
    );

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Yeni Tutar"),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
        context.read<UpdateAppointmentCubit>().updatePrice(parsed);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Geçerli bir sayı giriniz.")),
        );
      }
    }
  }
}
