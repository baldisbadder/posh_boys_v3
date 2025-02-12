import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // For kDebugMode
import '../models/event.dart';

Future<List<Event>> fetchEvents() async {
  final url = Uri.parse('https://poshboysbar.co.uk/wp-json/mo/v1/app-events-all');

  try {
    final response = await http.get(url);

    if (kDebugMode) {
      debugPrint('API Response Status: ${response.statusCode}');
      debugPrint('API Response Body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      if (jsonList.isEmpty) {
        debugPrint('⚠️ API returned an empty list.');
        return [];
      }

      return jsonList.map((jsonItem) => Event.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load events: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('❌ Error fetching events: $e');
    }
    return []; // Return empty list instead of throwing an error
  }
}
