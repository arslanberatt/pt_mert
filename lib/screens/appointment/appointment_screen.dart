import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:appointment_repository/appointment_repository.dart';
import 'package:pt_mert/blocs/create_appointment_bloc/create_appointment_bloc.dart';
import 'package:pt_mert/components/classic_appbar.dart';
import 'package:pt_mert/components/section_tile.dart';
import 'package:pt_mert/components/table_calendar.dart';
import 'package:pt_mert/components/text_field.dart';
import 'package:pt_mert/cubits/main_navigation_cubit.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  final Customer? initialCustomer;

  const AppointmentScreen({super.key, this.initialCustomer});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _appointmentDateTime;
  final TextEditingController _priceController = TextEditingController();
  bool _notified15MinBefore = true;

  @override
  void initState() {
    super.initState();
    _appointmentDateTime = DateTime.now();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (widget.initialCustomer == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Randevu oluşturmak için bir müşteri seçilmelidir."),
          ),
        );
        return;
      }
      final appointment = Appointment.empty.copyWith(
        customer: widget.initialCustomer!,
        date: _appointmentDateTime,
        price: double.tryParse(_priceController.text.trim()),
        notified15MinBefore: _notified15MinBefore,
      );
      context.read<CreateAppointmentBloc>().add(CreateAppointment(appointment));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateAppointmentBloc, CreateAppointmentState>(
          listener: (context, state) {
            if (state is CreateAppointmentSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Randevu başarıyla kaydedildi!")),
              );
              Navigator.pop(context, true);
              context.read<MainNavigationCubit>().changeTab(0);
            } else if (state is CreateAppointmentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Randevu oluşturulurken hata oluştu")),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: ClassicAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCalendarWidget(
                  initialSelectedDay: _appointmentDateTime,
                  initialAppointmentTime: _appointmentDateTime,
                  onDaySelectedForAppointment: (selectedDateTime) {
                    setState(() {
                      _appointmentDateTime = selectedDateTime;
                    });
                  },
                ),
                const SizedBox(height: 16),
                SectionTile(
                  icon: Icons.calendar_today_outlined,
                  title: widget.initialCustomer!.name,
                  subtitle: DateFormat(
                    'd MMMM y, HH:mm',
                    'tr_TR',
                  ).format(_appointmentDateTime),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      MyTextField(
                        controller: _priceController,
                        label: const Text('Fiyat (isteğe bağlı)'),
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
                    ],
                  ),
                ),
                SwitchListTile(
                  title: const Text("15 dk Önce Bildir"),
                  value: _notified15MinBefore,
                  onChanged: (val) =>
                      setState(() => _notified15MinBefore = val),
                  activeColor: AppColors.blackTextColor,
                  activeTrackColor: AppColors.hardGrayTextColor,
                  inactiveThumbColor: AppColors.blackTextColor,
                  inactiveTrackColor: AppColors.inputFieldColor,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: const Text("Randevu Oluştur"),
                    ),
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
