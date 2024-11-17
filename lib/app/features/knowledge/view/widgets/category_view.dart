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

  Color get _cardColor {
    if (isSelected) return Colors.blueGrey.shade600;
    return Colors.blueGrey.shade700;
  }

  @override
  Widget build(BuildContext context) {
    final completed = numberOfObtained >= total;
    Widget statusIcon = Icon(Icons.circle_outlined);
    if (completed) {
      statusIcon = Icon(Icons.star, color: Colors.amber);
    }
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: _cardColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
          child: Row(
            children: [
              Expanded(child: Text(category, maxLines: 2)),
              Text('$numberOfObtained/$total'),
              const SizedBox(width: 8),
              // Icon(statusIcon, color: AppColors.backgroundDark),
              statusIcon,
            ],
          ),
        ),
      ),
    );
  }
}
