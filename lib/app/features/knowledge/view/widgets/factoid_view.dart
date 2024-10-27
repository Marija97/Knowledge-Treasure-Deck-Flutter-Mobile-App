import 'package:flutter/material.dart';

import '../../../../data/models/factoid.dart';

class FactoidView extends StatelessWidget {
  const FactoidView(this.factoid);

  final Factoid factoid;

  @override
  Widget build(BuildContext context) {
    final statusIcon = Icons.radio_button_unchecked;
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
        child: Row(
          children: [
            Text(factoid.question),
            const Spacer(),
            Icon(statusIcon),
          ],
        ),
      ),
    );
  }
}
