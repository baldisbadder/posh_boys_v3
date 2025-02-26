// Flutter packages
import 'package:flutter/material.dart';

// Services
import '../services/event_service.dart';

// Models
import '../models/event.dart';

// Widgets
import '../widgets/home_sections.dart';
import '../widgets/screen_widgets.dart';

// Configs
import '../theme/app_colors.dart';

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
    WidgetsBinding.instance.addObserver(this);
    _futureEvents = fetchEvents(); // ✅ Fetch events on startup
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState? state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _futureEvents = fetchEvents(); // ✅ Refresh events when app resumes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeepBlack,
      body: Column(
        children: [
          const ScreenHeader(title: 'The Posh Boys Bar'), // ✅ Common Header
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder<List<Event>>(
                    future: _futureEvents,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error loading events', style: TextStyle(color: AppColors.textPrimaryWhite)));
                      }

                      List<Event> events = snapshot.data ?? [];
                      Event? nextEvent = events.isNotEmpty ? events.first : null;

                      return Column(
                        children: [
                          if (nextEvent != null) NextEventSection(nextEvent: nextEvent, events: events),
                          const HomeBeerSection(),
                          const DrinksAndOffersSection(),
                          const OpeningTimesSection(),
                          const OurLocationSection(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
