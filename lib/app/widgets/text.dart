import 'package:flutter/material.dart';

import '../common/dimensions.dart';

class AppText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;

  const AppText(this.text, {required this.size, this.color});

  const AppText.small(String text) : this(text, size: AppFontSizes.subtitle2);

  const AppText.medium(String text) : this(text, size: AppFontSizes.subtitle1);

  const AppText.large(String text) : this(text, size: AppFontSizes.subheading);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: size, color: color));
  }
}
