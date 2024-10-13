import 'package:flutter/material.dart';

import '../../../../data/models/factoid.dart';
import '../../../../theme/colors.dart';

class QuizCard extends StatefulWidget {
  const QuizCard(this.factoid);

  final Factoid factoid;

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  static final _textStyle = TextStyle(
    color: Colors.grey.shade800,
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.content,
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(children: [
          const Spacer(),
          Text(widget.factoid.question, style: _textStyle),
          const Spacer(flex: 4),
          Text(widget.factoid.correctAnswer, style: _textStyle),
          const Spacer(flex: 6),
          Row(children: [
            SizedBox(width: 20),
            Expanded(
              child: OutlinedButton(
                child: Text('To repeat 🔁'),
                onPressed: () {},
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: OutlinedButton(
                child: Text('To complete ✅'),
                onPressed: () {},
              ),
            ),
            SizedBox(width: 20),
          ]),
          const Spacer(),
        ]),
      ),
    );
  }
}
