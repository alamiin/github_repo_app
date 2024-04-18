import 'package:intl/intl.dart';

extension DateFormatter on String {
  String formatDate() {
    DateTime dateTime = DateTime.parse(this).toLocal();
    return DateFormat('MM-dd-yy hh:mm:s a').format(dateTime);
  }
}

