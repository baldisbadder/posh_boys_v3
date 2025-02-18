import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../config/constants_config.dart';

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
      children: imageUrls.take(4).map((imageUrl) {
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
