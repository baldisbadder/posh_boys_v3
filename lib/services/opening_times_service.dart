import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../config/api_config.dart';

Future<Map<String, dynamic>> fetchOpeningTimes() async {
  final url = Uri.parse(APIConfig.openingTimesEndpoint);

  try {
    final response = await http.get(url);
    //debugPrint('Response body: ${response.body} coee: ${response.statusCode}');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      String rawContent = jsonData['content']['rendered'] ?? '{}';

      // ✅ Remove HTML tags
      debugPrint('Stripping string');
      String cleanJsonString = _stripHtmlTags(rawContent);
      debugPrint('Stripped: $cleanJsonString');
      // ✅ Parse JSON
      return json.decode(cleanJsonString);
    } else {
      throw Exception('Service: Failed to load opening times');
    }
  } catch (e) {
    return {'Error': 'Service: Opening times not available'};
  }
}

// ✅ Function to get today's opening time
String getTodaysOpeningTime(Map<String, dynamic> openingTimes) {
  String today = DateFormat('EEEE').format(DateTime.now()); // Get current day as "Monday", "Tuesday", etc.
  return openingTimes[today] ?? 'No data';
}

// Function to strip HTML and double quote chars
String _stripHtmlTags(String htmlText) {
  // ✅ Remove HTML tags
  String strippedText = htmlText.replaceAll(RegExp(r'<[^>]*>'), '').trim();

  // ✅ Convert HTML entities for curly quotes to normal quotes
  strippedText = strippedText
      .replaceAll('&#8220;', '"') // Left curly quote → "
      .replaceAll('&#8221;', '"') // Right curly quote → "
      .replaceAll('&#8216;', "'") // Left single quote → '
      .replaceAll('&#8217;', "'"); // Right single quote → '

  // ✅ Decode any remaining HTML entities
  final unescape = HtmlUnescape();
  return unescape.convert(strippedText);
}
