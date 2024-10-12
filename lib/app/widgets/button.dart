import 'package:flutter/material.dart';

import '../theme/colors.dart';
import 'text.dart';

class AppButton extends StatelessWidget {
  const AppButton({required this.title, this.onTap});

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: double.infinity,
      height: 55,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.blueGrey.shade700,
      child: AppText.medium(title),
    );
  }
}
