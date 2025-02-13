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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.cardBGEspressoBrown, // Matches your theme
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: event.imageUrl.isNotEmpty
                  ? Image.network(event.imageUrl, width: 80, height: 80, fit: BoxFit.cover)
                  : Container(
                      width: 80,
                      height: 80,
                      color: AppColors.dividerCharcoalGrey,
                      child: const Icon(Icons.event, color: AppColors.textSecondaryWhite70, size: 40),
                    ),
            ),
            const SizedBox(width: 12),
            // Event Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimaryWhite),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Html(
                    data: event.description,
                    style: {
                      'body': Style(
                        fontSize: FontSize(14),
                        color: AppColors.textSecondaryWhite70,
                      ),
                    },
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${DateUtilsHelper.formatUKDate(event.startDate)} at ${event.startTime}', // Formats date nicely
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentGold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}