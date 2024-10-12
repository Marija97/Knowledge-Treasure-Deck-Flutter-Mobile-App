import 'package:flutter/material.dart';

class AppNavigationBarItem {
  final String label;
  final IconData icon;
  final Widget page;

  AppNavigationBarItem({
    required this.label,
    required this.icon,
    required this.page,
  });

  factory AppNavigationBarItem.feed({required Widget page}) => //
      AppNavigationBarItem(
        label: 'Feed',
        icon: Icons.menu_book_rounded,
        page: page,
      );

  factory AppNavigationBarItem.profile({required Widget page}) => //
      AppNavigationBarItem(
        label: 'Profile',
        icon: Icons.account_box_outlined,
        page: page,
      );

  factory AppNavigationBarItem.settings({required Widget page}) => //
      AppNavigationBarItem(
        label: 'Settings',
        icon: Icons.settings,
        page: page,
      );

  NavigationDestination get asDestination {
    return NavigationDestination(
      icon: Icon(icon, size: 26, color: Colors.blueGrey.shade800.withOpacity(.55)),
      selectedIcon: Icon(icon, size: 26, color: Colors.blueGrey.shade800),
      label: label,
    );
  }
}
