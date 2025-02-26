/* ====================== */
/* Screen Section Widgets */
/* ====================== */

// Flutter/dart
import 'package:flutter/material.dart';

// Generic config/functions
import '../config/constants_config.dart';
import '../theme/app_colors.dart';
import '../utils/date_utils.dart';

// General widgets
import '../widgets/screen_widgets.dart';

// Opening Times
import '../screens/opening_times_screen.dart';
import '../services/opening_times_service.dart';

// Events
import '../models/event.dart';
import '../screens/events_screen.dart';

// Beers
import '../models/beer.dart';
import '../services/beer_service.dart';
import '../screens/beer_screen.dart';


// ✅ Next Event Section
class NextEventSection extends StatelessWidget {
  final Event nextEvent;
  final List<Event> events;

  const NextEventSection({
    super.key,
    required this.nextEvent,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      title: 'Next event: ${DateUtilsHelper.getFriendlyEventDay(nextEvent.startDate)} - ${nextEvent.name}',
      bgColor: AppColors.highlightWarmAmber,
      content: '${DateUtilsHelper.formatUKDate(nextEvent.startDate)} ${nextEvent.startTime}',
      icon: Icons.event,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventsScreen(events: events)),
        );
      },
    );
  }
}

// Our location Section
class OurLocationSection extends StatelessWidget {
  const OurLocationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      title: 'Our Location',
      bgColor: AppColors.cardBGEspressoBrown,
      content: 'See where to find us!',
      icon: Icons.map,
      onTap: () {
        // Navigate to location screen
      },
    );
  }
}

// Opening Times Section
class OpeningTimesSection extends StatelessWidget {
  const OpeningTimesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchOpeningTimes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Text('Error loading opening times');
        }
    
        // ✅ Get today's opening time
        String todayOpening = getTodaysOpeningTime(snapshot.data!);
        return ClickableCard(
          title: 'Opening Times',
          content: 'Today: $todayOpening',
          icon: Icons.access_time,
          bgColor: Colors.brown, // Change to your preferred color
          onTap: () {
            // Navigate to full opening times screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OpeningTimesScreen(snapshot.data!)),
            );
          },
        );
      },
    );
  }
}

// Dirnks and Offers Section
class DrinksAndOffersSection extends StatelessWidget {
  const DrinksAndOffersSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      title: 'Drinks & Offers',
      bgColor: AppColors.accentGold,
      content: 'Check out our latest drinks and deals!',
      icon: Icons.local_drink,
      onTap: () {
        // Navigate to drinks & offers screen
      },
    );
  }
}

class HomeBeerSection extends StatefulWidget {
  const HomeBeerSection({super.key});

  @override
  HomeBeerSectionState createState() => HomeBeerSectionState();
}

class HomeBeerSectionState extends State<HomeBeerSection> {
  late Future<List<Beer>> _futureBeers;

  @override
  void initState() {
    super.initState();
    _futureBeers = BeerService.fetchBeers(); // ✅ Fetch beers from API
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Beer>>(
      future: _futureBeers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return ClickableCard(
            title: 'On Tap Now',
            content: 'Error loading beers',
            icon: Icons.local_drink,
            bgColor: AppColors.cardBGEspressoBrown,
            onTap: () => _navigateToBeerScreen(context),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return ClickableCard(
            title: 'On Tap Now',
            content: 'No beers currently on tap.',
            icon: Icons.local_drink,
            bgColor: AppColors.cardBGEspressoBrown,
            onTap: () => _navigateToBeerScreen(context),
          );
        }
        // ✅ Filter only "On Tap" beers (availability = 23)
        List<Beer> onTapBeers = snapshot.data!.where((beer) => 
          beer.availability == ConstantsConfig.beersAvailCodeOnTap).toList();
        // ✅ Extract up to 4 beer badge images (ignores empty image URLs)

        List<String> imageUrls = onTapBeers
            .map((beer) => beer.imageUrl)
            .where((url) => url.isNotEmpty) // ✅ Ensure no empty strings
            .take(8)
            .toList();
        return ClickableCard(
          title: 'On Tap Now',
          content: '', // ✅ No text content, just images
          icon: Icons.local_drink,
          bgColor: AppColors.cardBGEspressoBrown,
          onTap: () => _navigateToBeerScreen(context),
          imageUrls: imageUrls, // ✅ Pass beer images
        );
      },
    );
  }

  void _navigateToBeerScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BeerScreen()),
    );
  }
}