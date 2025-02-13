import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/event.dart';
import '../theme/app_colors.dart';
import '../utils/date_utils.dart';
class EventCard extends StatefulWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  EventCardState createState() => EventCardState();
}

class EventCardState extends State<EventCard> {
  bool _isExpanded = false; // ✅ Track if description is expanded

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBGEspressoBrown,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Event Image (or Placeholder)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: widget.event.imageUrl.isNotEmpty
                ? Image.network(
                    widget.event.imageUrl,
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
                  widget.event.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryWhite,
                  ),
                ),

                const SizedBox(height: 8),

                // ✅ Event Date & Time
                Text(
                  '${DateUtilsHelper.formatUKDate(widget.event.startDate)} at ${widget.event.startTime}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accentGold,
                  ),
                ),
                
                const SizedBox(height: 6),

                // ✅ Event Description (Collapsed/Expanded)
                Html(
                  data: _isExpanded
                      ? widget.event.description // ✅ Show full description
                      : '${widget.event.description.substring(0, 100)}...', // ✅ Show preview
                  style: {
                    'body': Style(
                      fontSize: FontSize(14),
                      color: AppColors.textSecondaryWhite70,
                    ),
                  },
                ),

                // ✅ "More/Less" Button to Expand Description
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded; // ✅ Toggle expand/collapse
                      });
                    },
                    child: Text(
                      _isExpanded ? 'Less' : 'More...',
                      style: const TextStyle(color: AppColors.accentGold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Placeholder Image Function
  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: 180,
      color: AppColors.dividerCharcoalGrey,
      alignment: Alignment.center,
      child: const Icon(Icons.image, size: 50, color: AppColors.textSecondaryWhite70),
    );
  }
}
