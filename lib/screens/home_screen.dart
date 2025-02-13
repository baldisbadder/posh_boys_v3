import 'package:flutter/material.dart';
import '../services/event_service.dart';
import '../models/event.dart';
import '../widgets/clickable_card.dart';
import '../theme/app_colors.dart';
import 'events_screen.dart';
import '../utils/date_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late Future<List<Event>> _futureEvents;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // ✅ Listen for app lifecycle changes
    _futureEvents = fetchEvents(); // ✅ Fetch all events once
  }

  // ✅ Detect when the app resumes from the background
  @override
  void didChangeAppLifecycleState(AppLifecycleState? state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _futureEvents = fetchEvents(); // ✅ Reload events when the app comes back from background
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Posh Boys Bar',
          style: TextStyle(color: AppColors.contrastSoftCream), // ✅ Use a light color for contrast
        ),
        backgroundColor: AppColors.backgroundDeepBlack,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.accentGold), // ✅ Ensure icons are visible too
      ),
      body: FutureBuilder<List<Event>>(
        future: _futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // ✅ Show loading spinner
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading events: ${snapshot.error}',
                style: const TextStyle(color: AppColors.textPrimaryWhite),
                ),
              );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildHomeContent(context, null); // ✅ No events but keep home screen layout
          }

          List<Event> events = snapshot.data!;
          Event nextEvent = events.first; // ✅ Get the first event

          return _buildHomeContent(context, nextEvent, events); // ✅ Pass next event and full event list
        },
      ),
    );
  }

  // ✅ Keep existing home sections, inject event card only if there's a next event
  Widget _buildHomeContent(BuildContext context, Event? nextEvent, [List<Event>? events]) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ✅ Next Event Card (Only if there's an upcoming event)
          if (nextEvent != null)
            ClickableCard(
              title: '${DateUtilsHelper.getFriendlyEventDay(nextEvent.startDate)}: ${nextEvent.name}',
              bgColor: AppColors.highlightWarmAmber,
              content: '${DateUtilsHelper.formatUKDate(nextEvent.startDate)} ${nextEvent.startTime}',
              icon: Icons.event,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventsScreen(events: events ?? [])), // ✅ Pass events list to events screen
                );
              },
            ),

          const SizedBox(height: 10),

          // ✅ Existing Sections (Modify based on what’s already in your home screen)
          ClickableCard(
            title: 'Drinks & Offers',
            bgColor: AppColors.accentGold,
            content: 'Check out our latest drinks and deals!',
            icon: Icons.local_drink,
            onTap: () {
              // Navigate to drinks & offers screen
            },
          ),

          const SizedBox(height: 10),

          ClickableCard(
            title: 'Opening Times',
            bgColor: AppColors.sectionBGClassicBeige,
            content: "Find out when we're open!",
            icon: Icons.schedule,
            onTap: () {
              // Navigate to opening times screen
            },
          ),

          const SizedBox(height: 10),

          ClickableCard(
            title: 'Our Location',
            bgColor: AppColors.cardBGEspressoBrown,
            content: 'See where to find us!',
            icon: Icons.map,
            onTap: () {
              // Navigate to location screen
            },
          ),
        ],
      ),
    );
  }
}
