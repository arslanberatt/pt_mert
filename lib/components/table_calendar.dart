import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pt_mert/utils/constants/colors.dart';

class CustomCalendarWidget extends StatefulWidget {
  final Function(DateTime selectedDay)? onDaySelectedForView;
  final Function(DateTime selectedDateTime)? onDaySelectedForAppointment;
  final DateTime? initialSelectedDay;
  final DateTime? initialAppointmentTime;

  const CustomCalendarWidget({
    super.key,
    this.onDaySelectedForView,
    this.onDaySelectedForAppointment,
    this.initialSelectedDay,
    this.initialAppointmentTime,
  });

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialSelectedDay ?? _focusedDay;
    _focusedDay = widget.initialSelectedDay ?? _focusedDay;

    if (widget.onDaySelectedForView != null && _selectedDay != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onDaySelectedForView!(_selectedDay!);
      });
    }
  }

  @override
  void didUpdateWidget(covariant CustomCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedDay != oldWidget.initialSelectedDay &&
        widget.initialSelectedDay != null) {
      setState(() {
        _selectedDay = widget.initialSelectedDay;
        _focusedDay = widget.initialSelectedDay!;
      });
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });

    if (widget.onDaySelectedForAppointment != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          widget.initialAppointmentTime ?? DateTime.now(),
        ),
      );

      DateTime finalDateTime;
      if (pickedTime != null) {
        finalDateTime = DateTime(
          selectedDay.year,
          selectedDay.month,
          selectedDay.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      } else {
        finalDateTime = DateTime(
          selectedDay.year,
          selectedDay.month,
          selectedDay.day,
          0,
          0,
        );
      }
      widget.onDaySelectedForAppointment!(finalDateTime);
    } else if (widget.onDaySelectedForView != null) {
      widget.onDaySelectedForView!(selectedDay); // Sadece seçilen günü bildir
    }
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'tr_TR',
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: _onDaySelected,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      headerVisible: false,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        todayDecoration: BoxDecoration(
          color: AppColors.todayColor.withOpacity(0.5), // Bugünün rengi
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: AppColors.selectedDayColor, // Seçili günün rengi
          shape: BoxShape.circle,
        ),
        weekendTextStyle: const TextStyle(color: Colors.red),
        defaultTextStyle: const TextStyle(color: Colors.black87),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: AppColors.blackTextColor,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: AppColors.blackTextColor,
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        weekendStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
      ),
    );
  }
}
