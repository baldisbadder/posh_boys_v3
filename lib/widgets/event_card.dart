import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/event.dart';
import '../theme/app_colors.dart';
import '../utils/string_utils.dart'; // ✅ Import helper to strip HTML
import '../utils/date_utils.dart';  // ✅ Import date helper

class EventCard extends StatefulWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  EventCardState createState() => EventCardState();
}

class EventCardState extends State<EventCard> {
  bool _isExpanded = false;
  

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Strip HTML tags from the description
    // String plainTextDescription = StringUtilsHelper.stripHTML(widget.event.description);

    // ✅ Convert newlines to HTML-friendly <br> tags
    String formattedDescription = widget.event.description
      .replaceAll('\r\n', '<br>') // Windows-style newlines
      .replaceAll('\n', '<br>') // Unix-style newlines
      .replaceAll('\r', '<br>'); // Mac-style newlines

    // ✅ Limit preview to approx. 3 lines (around 150-200 chars)
    /* String previewText = plainTextDescription.length > 100
        ? '${plainTextDescription.substring(0, 100)}...' // ✅ Show preview with ellipsis
        : plainTextDescription; */
    final int previewLines = 200;
    String previewText = formattedDescription.length > previewLines
      ? '${widget.event.description.substring(0,previewLines)}...'
      : widget.event.description;

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
                const SizedBox(height: 6),

                // ✅ Date & Time (Centered)
                Text(
                  '${DateUtilsHelper.formatUKDate(widget.event.startDate)} at ${widget.event.startTime}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accentGold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // ✅ Smooth Expand/Collapse
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Html(
                    data: previewText,
                    style: {
                      'body': Style(
                        fontSize: FontSize(14),
                        color: AppColors.textSecondaryWhite70,
                      ),
                    },
                  ),
                  /*Text(
                    previewText,
                    style: const TextStyle(fontSize: 14, color: AppColors.textSecondaryWhite70),
                  ), */
                  secondChild: Html(
                    data: formattedDescription,
                    style: {
                      'body': Style(
                        fontSize: FontSize(14),
                        color: AppColors.textSecondaryWhite70,
                      ),
                    },
                  ),
                ),

                // ✅ "More/Less" Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _toggleExpand,
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
