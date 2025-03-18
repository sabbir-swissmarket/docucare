import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/styles/app_font.dart';
import 'package:docucare/styles/app_styles.dart';
import 'package:docucare/utils/core.dart';

class AppTheme {
  static ThemeData get appTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: AppFont.appFontDefault,
        textTheme: const TextTheme(
          headlineLarge: AppStyles.headline1,
          headlineMedium: AppStyles.headline3,
          headlineSmall: AppStyles.headline5,
          bodyLarge: AppStyles.bodyLarge,
          bodyMedium: AppStyles.bodyMedium,
          bodySmall: AppStyles.bodySmall,
        ),
      );
}
