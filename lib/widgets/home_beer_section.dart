import 'package:flutter/material.dart';
import '../models/beer.dart';
import '../services/beer_service.dart';
import '../theme/app_colors.dart';
import '../screens/beer_screen.dart';
import '../widgets/clickable_card.dart';
import '../config/constants_config.dart';

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
            .take(4)
            .toList();
        debugPrint('Found urls: ${imageUrls.length}');
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
