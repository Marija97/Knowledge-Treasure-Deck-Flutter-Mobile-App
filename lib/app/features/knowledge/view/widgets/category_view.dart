import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView(this.category);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade400,
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
    );
  }
}
