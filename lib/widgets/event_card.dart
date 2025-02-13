import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/event.dart';
import '../theme/app_colors.dart';
import '../utils/date_utils.dart';
class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBGEspressoBrown, // ✅ Themed background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Display Event Image (or Placeholder if No Image)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: event.imageUrl.isNotEmpty
                ? Image.network(
                    event.imageUrl,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
                  )
                : _buildPlaceholderImage(),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Event Title
                Text(
                  event.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryWhite,
                  ),
                ),
                const SizedBox(height: 6),

                // ✅ Event Date & Time
                Center(
                  child: Text(
                    '${DateUtilsHelper.formatUKDate(event.startDate)} at ${event.startTime}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.accentGold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // ✅ Formatted Event Description with HTML Parsing
                Html(
                  data: event.description,
                  style: {
                    'body': Style(
                      fontSize: FontSize(14),
                      color: AppColors.textSecondaryWhite70,
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Placeholder Image Function (If No Image Available)
  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: 180,
      color: AppColors.dividerCharcoalGrey, // Placeholder background
      alignment: Alignment.center,
      child: const Icon(Icons.image, size: 50, color: AppColors.textSecondaryWhite70),
    );
  }
}
