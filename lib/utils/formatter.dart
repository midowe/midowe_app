import 'package:intl/intl.dart';

class Formatter {
  static String currency(int? number) {
    String output =
        NumberFormat.currency(locale: 'eu', symbol: '').format(number).trim();

    if (output.endsWith(',00')) {
      return output.substring(0, output.lastIndexOf(','));
    }

    return output;
  }

  static String currencyDouble(double? number) {
    String output =
        NumberFormat.currency(locale: 'eu', symbol: '').format(number).trim();

    if (output.endsWith(',00')) {
      return output.substring(0, output.lastIndexOf(','));
    }

    return output;
  }

  static String dayMonth(String? date) {
    final f1 = new DateFormat('yyyy-MM-dd');
    final f2 = new DateFormat('dd.MMM');
    DateTime dateTime = f1.parse(date!);
    return f2.format(dateTime);
  }
}
