import 'package:flutter/material.dart';

import 'colors.dart';
import '../common/dimensions.dart';

class AppTheme {
  factory AppTheme.dark() => _AppDarkTheme();
  factory AppTheme.light() => _AppLightTheme();

  ThemeData get data => ThemeData();

  Color get navigationBarDividerColor => AppColors.translucent;

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
  ThemeData get data => ThemeData.dark().copyWith(
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

  @override
  Color get navigationBarDividerColor => AppColors.dividerDark;
}

class _AppLightTheme implements AppTheme {
  @override
  ThemeData get data => ThemeData.light().copyWith(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColors.ashBeige,
          secondary: AppColors.accentLight,
        ),
        primaryColor: AppColors.canvasDark,
        canvasColor: AppColors.canvasDark,
        scaffoldBackgroundColor: AppColors.photoAlbumBackground,
        cardColor: AppColors.cardDark,
        dividerColor: AppColors.attachmentBorder,
        dialogBackgroundColor: AppColors.cardDark,
        textTheme: AppTheme._buildTextTheme(ThemeData.light()),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.photoAlbumBackground,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: AppColors.translucent,
          shadowColor: AppColors.translucent,
          surfaceTintColor: AppColors.translucent,
          height: 50,
        ),
      );

  @override
  Color get navigationBarDividerColor => AppColors.attachmentBorder;
}
