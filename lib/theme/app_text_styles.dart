import 'package:material_ui/material_ui.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.accentGold,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryWhite,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondaryWhite70,
  );
}
