import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Events'),
        backgroundColor: AppColors.deepBlack,
        iconTheme: const IconThemeData(color: AppColors.goldAccent),
      ),
      body: const Center(
        child: Text(
          'List of all events coming soon...',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
