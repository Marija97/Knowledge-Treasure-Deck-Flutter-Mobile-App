import 'package:flutter/material.dart';

import '../../../../data/models/factoid.dart';
import '../../../../theme/colors.dart';

class FactoidView extends StatelessWidget {
  const FactoidView(this.factoid);

  final Factoid factoid;

  @override
  Widget build(BuildContext context) {
    // final statusIcon = factoid.obtained
    //     ? Icons.radio_button_checked
    //     : Icons.radio_button_unchecked;
    final statusIcon = Icons.radio_button_unchecked;
    return Card(
      color: Colors.grey.shade400,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
        child: Row(
          children: [
            Text(factoid.question, style: TextStyle(color: Colors.black)),
            const Spacer(),
            Icon(statusIcon, color: AppColors.backgroundDark),
          ],
        ),
      ),
    );
  }
}
