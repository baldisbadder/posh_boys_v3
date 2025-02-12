import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // For kDebugMode
import '../models/event.dart';
import 'dart:io';

Future<List<Event>> fetchEvents() async {
  final url = Uri.parse('https://poshboysbar.co.uk/wp-json/mo/v1/app-events-all');

  try {
    final response = await http.get(url);

    if (kDebugMode) {
      debugPrint('API Response Status: ${response.statusCode}');
      debugPrint('API Response Body: ${response.body}');
    }

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((jsonItem) => Event.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('❌ Error fetching events: $e');
    }
    return []; // Return empty list instead of crashing
  }
}