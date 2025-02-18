import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/beer.dart';
import '../config/api_config.dart';

class BeerService {
  static const String _apiUrl = APIConfig.beersEndpoint;

  // ✅ Fetch Beers from API
  static Future<List<Beer>> fetchBeers() async {
    try {
      final url = Uri.parse(_apiUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);

        // ✅ Convert JSON into List of Beers
        return jsonList.map((jsonItem) => Beer.fromJson(jsonItem)).toList();
      } else {
        throw Exception('Failed to load beers. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching beers: $error');
    }
  }
}