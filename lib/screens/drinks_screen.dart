import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/screen_widgets.dart';

class DrinksScreen extends StatelessWidget {
  const DrinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Drinks & Offers'),
      body: Center(
        child: Text(
          'Drinks menu coming soon...',
          style: TextStyle(fontSize: 18, color: AppColors.textPrimaryWhite),
        ),
      ),
    );
  }
}
