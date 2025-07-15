import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/create_customer_bloc/create_customer_bloc.dart';
import 'package:pt_mert/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pt_mert/components/shimmer.dart';
import 'package:pt_mert/screens/home/customer_screen.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pt_mert/components/today.dart';
import 'package:pt_mert/utils/constants/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/gorilla.png"),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      BlocProvider<CreateCustomerBloc>(
                        create: (context) => CreateCustomerBloc(
                          customerRepository: FirebaseCustomerRepository(),
                        ),
                        child: CustomerScreen(),
                      ),
                ),
              );
            },
            icon: const Icon(Icons.person_add_rounded, color: Colors.black87),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.add_circle, color: Colors.black87),
          const SizedBox(width: 12),
        ],
      ),
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
                      return ShimmerWidget(width: 200, height: 28);
                    }
                  },
                ),
                SizedBox(height: 4),
                Text(
                  getFormattedTodayInTurkish(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 32),

            TableCalendar(
              locale: 'tr_TR',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              headerVisible: false,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: const Color.fromARGB(
                    255,
                    189,
                    195,
                    203,
                  ).withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: const Color.fromARGB(255, 36, 36, 37),
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: const TextStyle(color: Colors.red),
                defaultTextStyle: const TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 12),
            Text('Randevular', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  final appointments = [
                    {
                      "name": "Berat",
                      "package": "6. ders",
                      "time": "Saat 10:00",
                    },
                    {
                      "name": "Kübra",
                      "package": "10. ders",
                      "time": "Saat 11:00",
                    },
                    {
                      "name": "Tuğba",
                      "package": "1. ders",
                      "time": "Saat 14:00",
                    },
                    {
                      "name": "Şevval",
                      "package": "2. ders",
                      "time": "Saat 17:00",
                    },
                    {
                      "name": "Medine",
                      "package": "3. ders",
                      "time": "Saat 18:00",
                    },
                  ];

                  final appointment = appointments[index];

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
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
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
