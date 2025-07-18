import 'package:intl/intl.dart';

String getFormattedTodayInTurkish() {
  final now = DateTime.now();
  final turkishLocale = 'tr_TR';

  final formatter = DateFormat("EEEE, d MMMM y", turkishLocale);
  return formatter.format(now);
}

String formatDate(DateTime date) {
  return DateFormat('d MMMM y', 'tr_TR').format(date);
}

String formatTime(DateTime date) {
  return DateFormat('HH:mm', 'tr_TR').format(date);
}
