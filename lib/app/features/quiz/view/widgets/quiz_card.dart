import 'package:flutter/material.dart';

import '../../../../models/factoid.dart';
import '../../../../theme/colors.dart';

class QuizCard extends StatelessWidget {
  const QuizCard(this.factoid);

  final Factoid factoid;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.content,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(factoid.question, style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
