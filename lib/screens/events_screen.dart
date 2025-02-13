import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import '../theme/app_colors.dart';

class EventsScreen extends StatelessWidget {
  final List<Event> events; // ✅ Receive event list from HomeScreen

  const EventsScreen({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upcoming Events (${events.length})',
          style: const TextStyle(color: AppColors.accentGold),
        ),
        backgroundColor: AppColors.backgroundDeepBlack,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.screenTitleAccentGold),
      ),
      body: events.isEmpty
          ? const Center(child: Text('No upcoming events.', style: TextStyle(color: Colors.white, fontSize: 18)))
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventCard(event: events[index]); // ✅ Use already-fetched events
              },
            ),
    );
  }
}
