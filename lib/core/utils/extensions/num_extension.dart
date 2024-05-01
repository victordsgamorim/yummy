import 'package:intl/intl.dart';

extension DoubleExtensions on num {
  String get toCurrency =>
      NumberFormat.currency(locale: 'en', symbol: '\u20AC').format(this);
}
