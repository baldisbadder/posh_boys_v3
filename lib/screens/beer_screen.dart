import 'package:flutter/material.dart';
import '../models/beer.dart';
import '../services/beer_service.dart';
import '../theme/app_colors.dart';
import '../widgets/beer_card.dart';
import '../config/constants_config.dart';
import '../widgets/screen_widgets.dart';

class BeerScreen extends StatefulWidget {
  const BeerScreen({super.key});

  @override
  BeerScreenState createState() => BeerScreenState();
}

class BeerScreenState extends State<BeerScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Beer>> _futureBeers;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _futureBeers = BeerService.fetchBeers();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ScreenTitleWidget(titleText: 'Beers',),
        backgroundColor: AppColors.backgroundDeepBlack,
        foregroundColor: AppColors.textPrimaryWhite,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.accentGold,
          unselectedLabelColor: AppColors.textSecondaryWhite70,
          indicatorColor: AppColors.accentGold,
          tabs: const [
            Tab(text: 'On Tap'),
            Tab(text: 'Coming Soon'),
          ],
        ),
        iconTheme: const IconThemeData(color: AppColors.screenTitleAccentGold),
      ),
      body: FutureBuilder<List<Beer>>(
        future: _futureBeers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error loading beers',
                style: TextStyle(color: AppColors.textPrimaryWhite),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No beers found.',
                style: TextStyle(color: AppColors.textPrimaryWhite),
              ),
            );
          }

          // ✅ Separate beers into "On Tap" and "Coming Soon"
          List<Beer> onTapBeers = snapshot.data!
              .where((beer) => beer.availability == ConstantsConfig.beersAvailCodeOnTap)
              .toList();
          List<Beer> comingSoonBeers = snapshot.data!
              .where((beer) => beer.availability == ConstantsConfig.beersAvailCodeComingSoon)
              .toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildBeerList(onTapBeers),
              _buildBeerList(comingSoonBeers),
            ],
          );
        },
      ),
    );
  }

  // ✅ Builds the ListView for each tab
  Widget _buildBeerList(List<Beer> beers) {
    return beers.isEmpty
        ? const Center(
            child: Text(
              'No beers available',
              style: TextStyle(color: AppColors.textPrimaryWhite),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: beers.length,
            itemBuilder: (context, index) {
              return BeerCard(beer: beers[index]); // ✅ Display beer cards
            },
          );
  }
}


