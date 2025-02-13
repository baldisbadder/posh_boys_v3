import 'package:intl/intl.dart';

class DateUtilsHelper {
  // ✅ Function to return a human-readable day description for an event
  static String getFriendlyEventDay(DateTime eventDate) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime eventDay = DateTime(eventDate.year, eventDate.month, eventDate.day);

    // ✅ 1. Check if event is today
    if (eventDay == today) {
      return 'Today';
    }

    // ✅ 2. Check if event is tomorrow
    if (eventDay == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    }

    // ✅ 3. Check if event is within the current week (Sunday - Saturday)
    int daysUntilEvent = eventDay.difference(today).inDays;
    if (daysUntilEvent >= 2 && daysUntilEvent <= 6) {
      return "This ${DateFormat('EEEE').format(eventDate)}"; // e.g., "This Friday"
    }

    // ✅ 4. Check if event is next week (but within 7 days)
    if (daysUntilEvent >= 7 && daysUntilEvent <= 13) {
      return "Next ${DateFormat('EEEE').format(eventDate)}"; // e.g., "Next Tuesday"
    }

    // ✅ 5. Default fallback (event is far in the future)
    return 'Coming soon';
  }

  // ✅ Function to format date as DD/MM/YYYY HH:mm (UK Format)
  static String formatUKDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}