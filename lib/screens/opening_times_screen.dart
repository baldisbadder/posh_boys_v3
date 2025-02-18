import 'package:flutter/material.dart';
import '../theme/app_colors.dart'; // ✅ Importing theme colors
import '../widgets/screen_widgets.dart'; // ✅ Importing reusable screen title widget

class OpeningTimesScreen extends StatelessWidget {
  final Map<String, dynamic> openingTimes;

  const OpeningTimesScreen(this.openingTimes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Opening Times'), // ✅ Using reusable title widget
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: openingTimes.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ Aligns day & times properly
              children: [
                // ✅ Day Name (Bold Gold)
                Text(
                  entry.key, // Monday, Tuesday, etc.
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.accentGold,
                  ),
                ),
                // ✅ Opening Time (Off-White)
                Text(
                  entry.value, // 12PM – 9PM
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimaryWhite,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
