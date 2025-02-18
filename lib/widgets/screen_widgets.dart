import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ScreenTitleWidget extends StatelessWidget {
  final String titleText;

  const ScreenTitleWidget({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: const TextStyle(
        color: AppColors.accentGold,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SectionDividerWidget extends StatelessWidget {
  final String title;

  const SectionDividerWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: AppColors.dividerCharcoalGrey,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentGold,
                ),
              ),
            ),
            const Expanded(
              child: Divider(
                color: AppColors.dividerCharcoalGrey,
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom; // ✅ Allows optional tabs

  const CustomAppBar({super.key, required this.title, this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundDeepBlack, // ✅ Standardized Background
      iconTheme: const IconThemeData(color: AppColors.accentGold), // ✅ Standardized Icon
      title: ScreenTitleWidget(titleText: title), // ✅ Standardized Title
      centerTitle: true,
      bottom: bottom, // ✅ Add tabs if provided
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48); // ✅ Adjusted height if tabs exist
}