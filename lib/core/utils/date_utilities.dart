import 'package:intl/intl.dart';

class DateUtilities {
  static List<String> getMonthNames({String locale = 'en'}) {
    final DateFormat formatter = DateFormat.MMMM(locale);

    return List.generate(12, (index) {
      final date = DateTime(2025, index + 1, 1);
      return formatter.format(date);
    });
  }

  static int getMonthIndex(String month) {
    final monthNames = getMonthNames();
    return monthNames.indexOf(month) + 1;
  }
}
