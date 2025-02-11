import 'package:flutter/material.dart';
import 'section_card.dart';

class ClickableCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const ClickableCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SectionCard(
        title: title,
        content: content,
        icon: icon,
        color: color,
      ),
    );
  }
}
