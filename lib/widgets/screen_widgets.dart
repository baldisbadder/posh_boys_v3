import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../config/constants_config.dart';

class ScreenHeader extends StatelessWidget {
  final String title;

  const ScreenHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔹 Title text using the common TitleText widget
        ScreenTitleWidget(titleText: title),
        Image.asset(
          'assets/images/HeaderBorderTopBottom2.png',
          width: double.infinity, // Full width
          fit: BoxFit.contain,
        ),      ],
    );
  }
}

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
        fontSize: 32,
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

class ClickableCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color bgColor;
  final VoidCallback onTap;
  final List<String> imageUrls; // ✅ New optional parameter

  const ClickableCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.bgColor,
    required this.onTap,
    this.imageUrls = const [], // ✅ Default to empty list
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // ✅ Vertically center items
            children: [
              // ✅ Left Column: Icon + Content/Images
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryWhite,
                      ),
                    ),

                    // ✅ Show Image Row if images exist
                    if (imageUrls.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      _buildImageRow(),
                    ],

                    // ✅ Show content only if it's not empty
                    if (content.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        content,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryWhite70,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // ✅ Right Column: Arrow Icon (Always Visible)
              const SizedBox(width: 12), // ✅ Space between content and arrow
              const Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.iconSoftCream),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Properly spaced row of images
  Widget _buildImageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ✅ Ensures even spacing
      children: imageUrls.take(8).map((imageUrl) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: double.infinity, // ✅ Expands to available width
                height: ConstantsConfig.homeScreenCardImageDivider / imageUrls.length,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ✅ Placeholder for missing images
  Widget _buildPlaceholderImage() {
    return Container(
      width: 60,
      height: 60,
      color: AppColors.dividerCharcoalGrey,
      alignment: Alignment.center,
      child: const Icon(Icons.local_drink, size: 30, color: AppColors.textSecondaryWhite70),
    );
  }
}
