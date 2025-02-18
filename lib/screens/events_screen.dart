import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import '../widgets/screen_widgets.dart';

class EventsScreen extends StatelessWidget {
  final List<Event> events; // ✅ Receive event list from HomeScreen

  const EventsScreen({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Upcoming Events (${events.length})'),
      body: events.isEmpty
        ? const Center(
          child: Text(
            'No upcoming events.',
            style: TextStyle(
              color: Colors.white, fontSize: 18,
            ),
          ),
        )
        : ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return EventCard(event: events[index]); // ✅ Use already-fetched events
          },
        ),
    );
  }
}
