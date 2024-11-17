import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/quiz_controller.dart';
import '../../controllers/quiz_state.dart';

class QuizCard extends ConsumerWidget {
  const QuizCard(this.category);

  final String category;

  static final textStyle = TextStyle(fontSize: 17);

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
          color: Colors.blueGrey.shade600,
          borderRadius: QuizCard.cardBorderRadius,
        ),
        padding: EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(children: [
                      Icon(
                        Icons.star,
                        color:
                            state.obtained ? Colors.white : Colors.transparent,
                      ),
                      const Spacer(),
                    ]),

                    /// --- Question view ---
                    Text(factoid.question, style: QuizCard.textStyle),
                    const SizedBox(height: 10),

                    /// --- Hint view ---
                    Visibility(
                      visible: state.showHint,
                      replacement: IconButton(
                        onPressed: controller.toggleHintVisibility,
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.white.withOpacity(
                            factoid.hint != null ? 0.5 : 0,
                          ),
                        ),
                      ),
                      child: Text(
                        factoid.hint ?? 'err',
                        style: QuizCard.textStyle,
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// --- Correct answer view ---
                    Visibility(
                      visible: state.showCorrectAnswer,
                      replacement: Icon(
                        Icons.question_mark,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: Text(
                        factoid.correctAnswer,
                        style: QuizCard.textStyle.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                  ],
                ),
              ),
              if (state.mode == QuizMode.testing &&
                  state.showCorrectAnswer &&
                  !state.obtained)
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: OutlinedButton(
                    child: Text('Totally knew that ✅'),
                    onPressed: controller.markAsObtained,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
