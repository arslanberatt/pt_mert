import 'package:appointment_repository/appointment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pt_mert/blocs/get_appointment_bloc/get_appointment_bloc.dart';
import 'package:pt_mert/blocs/get_customer_bloc/get_customer_bloc.dart';
import 'package:pt_mert/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pt_mert/components/appbar.dart';
import 'package:pt_mert/components/section_tile.dart';
import 'package:pt_mert/components/section_title.dart';
import 'package:pt_mert/components/shimmer.dart';
import 'package:pt_mert/components/table_calendar.dart';
import 'package:pt_mert/screens/appointment/appointment_detail_screen.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:pt_mert/components/today.dart';
import 'package:pt_mert/utils/constants/sizes.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _currentSelectedDay = DateTime.now();

  List<Appointment> _getAppointmentsForDay(
    List<Appointment> appointments,
    DateTime day,
  ) {
    return appointments.where((appointment) {
      return isSameDay(appointment.date, day);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    context.read<GetCustomerBloc>().add(GetCustomer());
    context.read<GetAppointmentBloc>().add(GetAppointment());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingPage),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<MyUserBloc, MyUserState>(
              builder: (context, state) {
                if (state.status == MyUserStatus.success) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hoşgeldin, ${state.user!.name}',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        getFormattedTodayInTurkish(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  );
                } else {
                  return const ShimmerWidget(width: 200, height: 28);
                }
              },
            ),
            const SizedBox(height: 32),
            CustomCalendarWidget(
              initialSelectedDay: _currentSelectedDay,
              onDaySelectedForView: (selectedDay) {
                setState(() {
                  _currentSelectedDay = selectedDay;
                });
              },
            ),
            const SizedBox(height: 12),
            SectionTitle(
              title:
                  'Randevular - ${DateFormat('d MMMM y', 'tr_TR').format(_currentSelectedDay)}',
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<GetAppointmentBloc, GetAppointmentState>(
                builder: (context, state) {
                  if (state is GetAppointmentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is GetAppointmentFailure) {
                    return const Center(child: Text("Randevular yüklenemedi."));
                  }
                  if (state is GetAppointmentSuccess) {
                    final appointmentsForSelectedDay = _getAppointmentsForDay(
                      state.appointments,
                      _currentSelectedDay,
                    );
                    if (appointmentsForSelectedDay.isEmpty) {
                      return Center(
                        child: Text(
                          'Bu güne ait randevu bulunmamaktadır.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: appointmentsForSelectedDay.length,
                      itemBuilder: (context, index) {
                        final appointment = appointmentsForSelectedDay[index];
                        return GestureDetector(
                          onTap: () async {
                            final updatedAppointment = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AppointmentDetailScreen(
                                  appointment: appointment,
                                ),
                              ),
                            );

                            if (updatedAppointment != null) {
                              await FirebaseAppointmentRepository()
                                  .updateAppointment(updatedAppointment);
                              context.read<GetAppointmentBloc>().add(
                                GetAppointment(),
                              );
                            }
                          },
                          child: SectionTile(
                            title: appointment.customer.name,
                            subtitle: appointment.status.value,
                            icon: Icons.calendar_today,
                            trailing: Text(
                              DateFormat("HH:mm").format(appointment.date),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
