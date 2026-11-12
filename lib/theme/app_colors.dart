import 'package:material_ui/material_ui.dart';

class AppColors {
  // 🔹 Background Colors
  static const Color backgroundDeepBlack = Color(0xFF1C1C1C); // ✅ Used for screen & app background

  // 🔹 Card Backgrounds
  static const Color cardBGEspressoBrown = Color(0xFF4D382D); // ✅ Used for all clickable cards & sections

  // 🔹 Section & Feature Highlights
  static const Color sectionBGClassicBeige = Color(0xFFC4A484); // ✅ Used for Opening Times, neutral UI elements
  static const Color highlightWarmAmber = Color(0xFFD2B48C); // ✅ Used for Next Event card, sections needing attention

  // 🔹 Dividers & Placeholders
  static const Color dividerCharcoalGrey = Color(0xFF333333); // ✅ Used for dividers, subtle UI elements

  // 🔹 Accent & Text Colors
  static const Color accentGold = Color(0xFFCFA15B); // ✅ Used for key highlights (back button, important text)
  static const Color contrastSoftCream = Color(0xFFF5E1C8); // ✅ Used for icons/text on dark backgrounds

  // 🔹 UI Element Colors
  static const Color iconSoftCream = contrastSoftCream; // ✅ Used for icons inside cards
  static const Color textPrimaryWhite = Colors.white; // ✅ Used for main titles & headlines
  static const Color textSecondaryWhite70 = Colors.white70; // ✅ Used for descriptions & secondary text
  static const Color screenTitleAccentGold = accentGold; // ✅ Used for sub screen titles
}
