import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/beer.dart';
import '../theme/app_colors.dart';

class BeerCard extends StatelessWidget {
  final Beer beer;

  const BeerCard({super.key, required this.beer});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.2; // ✅ 20% of screen width

    return Card(
      color: AppColors.cardBGEspressoBrown,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // ✅ Aligns content to top
          children: [
            // ✅ Beer Badge Image (Fixed width, auto height)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: beer.imageUrl.isNotEmpty
                  ? Image.network(
                      beer.imageUrl,
                      width: imageWidth,
                      fit: BoxFit.contain, // ✅ Keeps aspect ratio
                      errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(imageWidth),
                    )
                  : _buildPlaceholderImage(imageWidth),
            ),
            const SizedBox(width: 12),

            // ✅ Expanded Column for Beer Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Beer Name
                  Text(
                    beer.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryWhite,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // ✅ Beer Description (Render HTML)
                  Html(
                    data: beer.description,
                    style: {
                      'body': Style(
                        fontSize: FontSize(14),
                        color: AppColors.textSecondaryWhite70,
                        margin: Margins.zero, // ✅ Prevents extra spacing
                      ),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Placeholder Image for Missing Beer Badges
  Widget _buildPlaceholderImage(double width) {
    return Container(
      width: width,
      height: width * 1.2, // ✅ Slightly taller for aspect ratio
      color: AppColors.dividerCharcoalGrey,
      alignment: Alignment.center,
      child: const Icon(Icons.local_drink, size: 30, color: AppColors.textSecondaryWhite70),
    );
  }
}
