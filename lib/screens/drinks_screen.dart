import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DrinksScreen extends StatelessWidget {
  const DrinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drinks & Offers'),
        backgroundColor: AppColors.backgroundDeepBlack,
        iconTheme: const IconThemeData(color: AppColors.accentGold),
      ),
      body: const Center(
        child: Text(
          'Drinks menu coming soon...',
          style: TextStyle(fontSize: 18, color: AppColors.textPrimaryWhite),
        ),
      ),
    );
  }
}
