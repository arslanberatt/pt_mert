import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTimePicker extends StatefulWidget {
  final DateTime? initialDate;
  final void Function(DateTime selected) onDateTimeSelected;
  final String title;

  const CustomDateTimePicker({
    super.key,
    this.initialDate,
    required this.onDateTimeSelected,
    this.title = "Tarih", DateTime? initialValue,
  });

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDate ?? DateTime.now();
  }

  String _formatDateTime(DateTime dateTime) {
    final date = DateFormat('d MMMM y', 'tr').format(dateTime);
    final time = (dateTime.hour != 0 || dateTime.minute != 0)
        ? ' - ${DateFormat('HH:mm').format(dateTime)}'
        : '';
    return '$date$time';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      subtitle: Text(_formatDateTime(_selectedDateTime)),
      trailing: const Icon(Icons.calendar_today_rounded),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDateTime,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          locale: const Locale('tr', 'TR'),
        );

        if (pickedDate != null) {
          final askTime = await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Saat eklemek ister misiniz?"),
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

          if (askTime == true) {
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (pickedTime != null) {
              _selectedDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
            } else {
              _selectedDateTime = pickedDate;
            }
          } else {
            _selectedDateTime = pickedDate;
          }

          setState(() {}); // UI güncelle
          widget.onDateTimeSelected(_selectedDateTime); // callback
        }
      },
    );
  }
}
