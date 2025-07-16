import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pt_mert/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pt_mert/components/appbar.dart';
import 'package:pt_mert/components/shimmer.dart';
import 'package:pt_mert/components/table_calendar.dart';
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
  List<Map<String, String>> _allAppointments = [
    {
      "name": "Berat Arslan",
      "package": "6. ders",
      "time": "09:00 - 10:00",
      "date": "2025-07-16",
    },
    {
      "name": "Kübranur Demir",
      "package": "10. ders",
      "time": "10:00 - 11:00",
      "date": "2025-07-16",
    },
    {
      "name": "Tuğba Demir",
      "package": "1. ders",
      "time": "13:00 - 14:00",
      "date": "2025-07-17",
    },
    {
      "name": "Şevval Ümit",
      "package": "2. ders",
      "time": "16:00 - 17:00",
      "date": "2025-07-16",
    },
    {
      "name": "Medine Nur Kara",
      "package": "3. ders",
      "time": "17:00 - 18:00",
      "date": "2025-07-17",
    },
  ];

  List<Map<String, String>> _getAppointmentsForDay(DateTime day) {
    return _allAppointments.where((appointment) {
      try {
        DateTime appointmentDate = DateTime.parse(appointment["date"]!);
        return isSameDay(appointmentDate, day);
      } catch (e) {
        print("Randevu tarihi format hatası: ${appointment["date"]}");
        return false;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appointmentsForSelectedDay = _getAppointmentsForDay(
      _currentSelectedDay,
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingPage),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<MyUserBloc, MyUserState>(
                  builder: (context, state) {
                    if (state.status == MyUserStatus.success) {
                      return Text(
                        'Hoşgeldin, ${state.user!.name}',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                      );
                    } else {
                      return const ShimmerWidget(width: 200, height: 28);
                    }
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  getFormattedTodayInTurkish(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 32),
            // HomeScreen için CustomCalendarWidget kullanımı
            CustomCalendarWidget(
              initialSelectedDay:
                  _currentSelectedDay, // Başlangıçta bugünü seçili göster
              onDaySelectedForView: (selectedDay) {
                setState(() {
                  _currentSelectedDay = selectedDay; // Seçilen günü güncelle
                });
              },
            ),
            const SizedBox(height: 12),
            Text(
              'Randevular (${DateFormat('d MMMM y', 'tr_TR').format(_currentSelectedDay)})',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: appointmentsForSelectedDay.isEmpty
                  ? Center(
                      child: Text(
                        'Bu güne ait randevu bulunmamaktadır.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : ListView.builder(
                      itemCount: appointmentsForSelectedDay.length,
                      itemBuilder: (context, index) {
                        final appointment = appointmentsForSelectedDay[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appointment["name"]!,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Paket: ${appointment["package"]}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                              Text(
                                appointment["time"]!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
