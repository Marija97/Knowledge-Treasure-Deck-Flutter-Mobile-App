import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView(this.category, {this.isSelected = false, this.onTap});

  final String category;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
              // Icon(statusIcon, color: AppColors.backgroundDark),
            ],
          ),
        ),
      ),
    );
  }
}
