import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/section_card.dart';
import '../widgets/clickable_card.dart';
import 'events_screen.dart';
import 'drinks_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Posh Boys Bar', style: TextStyle(color: AppColors.goldAccent)),
        backgroundColor: AppColors.deepBlack,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionCard(
              title: "Opening Times",
              content: "Mon-Fri: 5PM - 11PM\nSat-Sun: 12PM - 12AM",
              icon: Icons.access_time,
              color: AppColors.espressoBrown,
            ),
            SectionCard(
              title: "Our Location",
              content: "123 Posh Street, London, UK",
              icon: Icons.location_on,
              color: AppColors.classicBeige,
            ),
            ClickableCard(
              title: "Next Event: Open Mic Night 🎤",
              content: "Join us for live performances!",
              icon: Icons.event,
              color: AppColors.warmAmber,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EventsScreen()));
              },
            ),
            ClickableCard(
              title: "Drink Offers",
              content: "2 Cocktails for £11 🍹",
              icon: Icons.local_bar,
              color: AppColors.goldAccent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DrinksScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
