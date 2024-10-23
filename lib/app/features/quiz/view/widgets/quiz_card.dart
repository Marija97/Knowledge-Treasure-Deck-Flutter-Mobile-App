import 'package:ash/app/features/quiz/controllers/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/colors.dart';
import '../../controllers/quiz_state.dart';

class QuizCard extends ConsumerWidget {
  const QuizCard(this.category);

  final String category;

  static final textStyle = TextStyle(color: Colors.grey.shade800, fontSize: 17);

  static final cardBorderRadius = BorderRadius.all(Radius.circular(20));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(quizControllerProvider(category).notifier);
    final state = ref.watch(quizControllerProvider(category));

    if (state.completed) return Text('Completed!!');
    if (state.factoid == null) return Text('Some error!');

    final factoid = state.factoid!;

    return InkWell(
      onTap: controller.nextView,
      borderRadius: QuizCard.cardBorderRadius,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.content,
          borderRadius: QuizCard.cardBorderRadius,
        ),
        padding: EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              if (state.obtained)
                Row(children: [
                  Icon(Icons.star),
                  const Spacer(),
                ]),
              const SizedBox(height: 30),

              /// --- Question view ---
              Text(factoid.question, style: QuizCard.textStyle),
              const SizedBox(height: 10),

              /// --- Hint view ---
              if (factoid.hint != null)
                Visibility(
                  visible: state.showHint,
                  replacement: IconButton(
                    onPressed: controller.toggleHintVisibility,
                    icon: Icon(Icons.info_outline),
                  ),
                  child: Text(
                    factoid.hint ?? 'err',
                    style: QuizCard.textStyle.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              const Spacer(),

              /// --- Correct answer view ---
              Visibility(
                visible: state.showCorrectAnswer,
                replacement: Icon(Icons.question_mark),
                child: Text(
                  factoid.correctAnswer,
                  style: QuizCard.textStyle,
                ),
              ),
              const Spacer(),

              if (state.mode == QuizMode.testing && state.showCorrectAnswer)
                OutlinedButton(
                  child: Text('Totally knew that ✅'),
                  onPressed: controller.markAsObtained,
                ),

              Visibility(
                visible: state.showCorrectAnswer,
                child: Text(
                  factoid.explanation ?? '',
                  style: QuizCard.textStyle,
                ),
              ),
              const SizedBox(height: 25),
              Visibility(
                visible: state.showCorrectAnswer,
                child: Text(
                  factoid.example ?? '',
                  style: QuizCard.textStyle,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
