// import 'package:flutter/foundation.dart'; // Only needed for debuging

class Beer {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String availability; // 22 = On Tap, 23-24 = Coming Soon

  // ✅ Constructor
  Beer({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.availability,
  });

  // ✅ Factory method to create an instance from JSON
  factory Beer.fromJson(Map<String, dynamic> json) {
    /* if (kDebugMode) {
      debugPrint('Received JSON: ${json.toString()}'); // ✅ Logs only in Debug Mode
    } */

    return Beer(
      id: json['id'] as String? ?? '0',
      name: json['beername'] as String? ?? 'Unknown Beer',
      description: json['beerdescription'] as String? ?? 'No description available.',
      imageUrl: json['imageurl'] as String? ?? '', // Empty string if no image
      availability: json['availcode'] as String? ?? '0', // Defaults to 0 if null
    );
  }
}