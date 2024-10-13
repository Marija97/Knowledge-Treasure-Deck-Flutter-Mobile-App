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
  bool showCorrectAnswer = false;

  static final _textStyle = TextStyle(
    color: Colors.grey.shade800,
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        showCorrectAnswer = !showCorrectAnswer;
      }),
      child: Card(
        color: AppColors.content,
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(children: [
            const SizedBox(height: 30),
            Text(widget.factoid.question, style: _textStyle),
            const SizedBox(height: 130),
            Visibility(
              visible: !showCorrectAnswer,
              child: Icon(Icons.question_mark),
              replacement: Text(
                widget.factoid.correctAnswer,
                style: _textStyle,
              ),
            ),
            const SizedBox(height: 130),
            if (showCorrectAnswer)
              OutlinedButton(
                child: Text('Totally knew that ✅'),
                onPressed: () {},
              ),
            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}
