import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import '../common/dimensions.dart';

abstract class AppTheme {
  factory AppTheme.dark() => _AppDarkTheme();

  factory AppTheme.light() => _AppLightTheme();

  ThemeData get data;

  static TextTheme _buildTextTheme(ThemeData base) {
    final textTheme = base.textTheme;

    return textTheme.copyWith(
      displayLarge: textTheme.displayLarge?.copyWith(
        fontSize: AppFontSizes.headline1,
      ),
      displaySmall: textTheme.displaySmall?.copyWith(
        fontSize: AppFontSizes.headline2,
      ),
      headlineMedium: textTheme.headlineMedium?.copyWith(
        fontSize: AppFontSizes.headline3,
      ),
      headlineSmall: textTheme.headlineSmall?.copyWith(
        fontSize: AppFontSizes.headline4,
      ),
      titleLarge: textTheme.titleLarge?.copyWith(
        fontSize: AppFontSizes.headline5,
      ),
      titleMedium: textTheme.titleMedium?.copyWith(
        fontSize: AppFontSizes.headline6,
      ),
    );
  }
}

class _AppDarkTheme implements AppTheme {
  @override
  ThemeData get data =>
      ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: AppColors.accentDark,
          secondary: AppColors.accentDark,
        ),
        primaryColor: AppColors.primaryDark,
        canvasColor: AppColors.canvasDark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        cardColor: AppColors.cardDark,
        dividerColor: AppColors.dividerDark,
        dialogBackgroundColor: AppColors.cardDark,
        textTheme: AppTheme._buildTextTheme(ThemeData.dark()),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.backgroundDark,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: AppColors.translucent,
          height: 70,
        ),
      );
}

class _AppLightTheme implements AppTheme {
  // Color(0xFF708090) // Color(0xFF778899);
  static final foregroundColor = Colors.blueGrey.shade700;

  @override
  ThemeData get data =>
      ThemeData(
        primaryColor: Color(0xFFDD8858),
        primaryColorLight: Color(0xFFD6CFCF),
        primaryColorDark: Color(0xFFB2C4B8),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFB77F5C),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFFDD8858),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardTheme: CardTheme(
          color: foregroundColor, // Darker card background
          shadowColor: Color(0xFFAC5E2D).withOpacity(0.5),
          elevation: 8, // Increased elevation for cards
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColors.ashBeige,
          secondary: AppColors.accentLight,
        ),
        canvasColor: AppColors.canvasDark,
        cardColor: Colors.blueGrey.shade800,
        dividerColor: AppColors.attachmentBorder,
        dialogBackgroundColor: AppColors.cardDark,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.photoAlbumBackground,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: AppColors.translucent,
          shadowColor: AppColors.translucent,
          surfaceTintColor: AppColors.translucent,
          height: 50,
        ),
      );
}
