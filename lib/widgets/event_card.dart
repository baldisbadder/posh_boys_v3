import 'package:flutter/material.dart';
import '../models/event.dart';
import '../theme/app_colors.dart';
import 'package:intl/intl.dart'; // For date formatting

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.espressoBrown, // Matches your theme
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
                      color: AppColors.charcoalGrey,
                      child: const Icon(Icons.event, color: Colors.white70, size: 40),
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
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.description,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(event.startDate), // Formats date nicely
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.goldAccent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Format date to UK format
  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }
}