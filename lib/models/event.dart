import 'package:flutter/foundation.dart';

class Event {
  final String name;
  final String description;
  final String imageUrl;
  final DateTime startDate;
  final String startTime;

  Event({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.startTime,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      debugPrint('Received JSON: ${json.toString()}'); // ✅ Logs only in Debug Mode
    }

    return Event(
      name: json['eventname']?.toString() ?? 'Unnamed Event',
      description: json['eventdescription']?.toString() ?? 'No description available.',
      imageUrl: json['imageurl']?.toString() ?? '',
      startDate: _parseStartDate(json['startdate']),
      startTime: json['starttime'],
    );
  }

  static DateTime _parseStartDate(dynamic startDate) {
    if (startDate == null) {
      return DateTime(2025, 1, 1); // Default fallback date
    }

    try {
      int timestamp = int.tryParse(startDate.toString()) ?? 0;
      return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error parsing date: $e'); // ✅ Truncated error message
      }
      return DateTime(2025, 1, 1); // Fallback date
    }
  }
}
