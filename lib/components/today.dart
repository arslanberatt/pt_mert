import 'package:intl/intl.dart';

String getFormattedTodayInTurkish() {
  final now = DateTime.now();
  final turkishLocale = 'tr_TR';

  final formatter = DateFormat("EEEE, d MMMM y", turkishLocale);
  return formatter.format(now);
}
