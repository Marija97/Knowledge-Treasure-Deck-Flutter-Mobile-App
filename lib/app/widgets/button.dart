import 'package:flutter/material.dart';

import 'text.dart';

class AppButton extends StatelessWidget {
  const AppButton({required this.title, this.onTap});

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      child: AppText.medium(title),
    );
  }
}
