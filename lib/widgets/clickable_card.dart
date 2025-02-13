import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class ClickableCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color bgColor;
  final VoidCallback onTap;

  const ClickableCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: bgColor, // ✅ Centralized card color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, size: 28, color: AppColors.iconSoftCream), // ✅ Icon color from theme
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimaryWhite), // ✅ Themed text
                    ),
                    const SizedBox(height: 4),
                    Text(
                      content,
                      style: const TextStyle(fontSize: 14, color: AppColors.textSecondaryWhite70), // ✅ Themed secondary text
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.iconSoftCream), // ✅ Clickable Indicator
            ],
          ),
        ),
      ),
    );
  }
}
