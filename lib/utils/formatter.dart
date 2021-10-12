import 'package:intl/intl.dart';

class Formatter {
  static String currency(int? number) {
    return NumberFormat.currency(locale: 'eu', symbol: '')
        .format(number)
        .trim();
  }

  static String dayMonth(String? date) {
    final f1 = new DateFormat('yyyy-MM-dd');
    final f2 = new DateFormat('dd.MMM');
    DateTime dateTime = f1.parse(date!);
    return f2.format(dateTime);
  }
}
