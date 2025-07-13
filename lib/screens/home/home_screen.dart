import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:pt_mert/components/bottom_nav.dart';
import 'package:pt_mert/components/shimmer.dart';
import 'package:pt_mert/screens/home/appointment_screen.dart';
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
  CalendarFormat _calendarFormat = CalendarFormat.week;
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onFabPressed() {}
  @override
  Widget build(BuildContext context) {
    //Yeni randevu eklendiğinde burada sayfanın dinlemesi için bloclistneer ile appointmentbloc çağırmalıyız
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
                  builder: (BuildContext context) => const CustomerScreen(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _calendarFormat = _calendarFormat == CalendarFormat.month
                          ? CalendarFormat.week
                          : CalendarFormat.month;
                    });
                  },
                  icon: Icon(
                    _calendarFormat == CalendarFormat.month
                        ? Icons.expand_less
                        : Icons.expand_more,
                  ),
                  label: Text(
                    _calendarFormat == CalendarFormat.month
                        ? "Küçült"
                        : "Büyüt",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            /// Takvim
            TableCalendar(
              locale: 'tr_TR',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
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
                // todayDecoration: BoxDecoration(
                //   // ignore: deprecated_member_use
                //   color: const Color.fromARGB(
                //     255,
                //     39,
                //     105,
                //     176,
                //   ).withOpacity(0.7),
                //   shape: BoxShape.circle,
                // ),
                // selectedDecoration: BoxDecoration(
                //   color: Colors.deepPurple,
                //   shape: BoxShape.rectangle,
                // ),
                weekendTextStyle: const TextStyle(color: Colors.red),
                defaultTextStyle: const TextStyle(color: Colors.black87),
              ),
            ),

            const SizedBox(height: 12),

            if (_selectedDay != null)
              Text(
                'Seçilen gün: ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            else
              const Text("Bir gün seçin..."),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[700 - (100 * (index - 1))],
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AppointmentScreen(),
            ),
          );
        },
        shape: CircleBorder(),
        // ignore: sort_child_properties_last
        child: Icon(Icons.add, size: 32, color: AppColors.backgroundColor),
        backgroundColor: AppColors.primaryTextColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        onFabTap: _onFabPressed,
      ),
    );
  }
}
