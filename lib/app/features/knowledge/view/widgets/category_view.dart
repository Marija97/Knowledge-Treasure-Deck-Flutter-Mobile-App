import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

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
    final statusIcon = numberOfObtained == total
        ? Icons.check_box
        : Icons.check_box_outline_blank;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.blueGrey.shade300 : Colors.grey.shade400,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
          child: Row(
            children: [
              Text(category, style: TextStyle(color: Colors.black)),
              const Spacer(),
              Text(
                '$numberOfObtained/$total',
                style: TextStyle(color: AppColors.backgroundDark),
              ),
              const SizedBox(width: 8),
              Icon(statusIcon, color: AppColors.backgroundDark),
            ],
          ),
        ),
      ),
    );
  }
}
