import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView(
    this.category, {
    this.isSelected = false,
    this.onTap,
    required this.total,
    required this.numberOfObtained,
  });

  final String category;
  final bool isSelected;
  final VoidCallback? onTap;
  final int total;
  final int numberOfObtained;

  @override
  Widget build(BuildContext context) {
    final cardColorOpacity = isSelected ? 0.95 : 0.8;
    final statusIcon = numberOfObtained == total
        ? Icons.check_box
        : Icons.check_box_outline_blank;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.blueGrey.withOpacity(cardColorOpacity),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
          child: Row(
            children: [
              Text(category),
              const Spacer(),
              Text('$numberOfObtained/$total'),
              const SizedBox(width: 8),
              // Icon(statusIcon, color: AppColors.backgroundDark),
              Icon(statusIcon),
            ],
          ),
        ),
      ),
    );
  }
}
