import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_flow/app/features/quiz/controllers/quiz_state.dart';

import '../../../widgets/button.dart';
import '../../../widgets/text.dart';
import '../controllers/quiz_controller.dart';
import 'widgets/quiz_card.dart';

class QuizPage extends ConsumerWidget {
  const QuizPage(this.category);

  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(quizControllerProvider(category).notifier);
    final state = ref.watch(quizControllerProvider(category));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          // Todo global padding
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Expanded(
                  child: AppText.large('${state.mode.name} :)'),
                ),
                AppButton(
                  title: 'Learn',
                  onTap: () => controller.switchQuizMode(QuizMode.learning),
                ),
                AppButton(
                  title: 'Test',
                  onTap: () => controller.switchQuizMode(QuizMode.testing),
                ),
                AppButton(
                  title: 'Evaluate',
                  onTap: () => controller.switchQuizMode(QuizMode.evaluating),
                ),
              ]),
              const Spacer(),
              QuizCard(category),
              const SizedBox(height: 15),
              if (!state.completed) Text(controller.progressPrint),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'Previous',
                      onTap:
                          controller.hasPrevious ? controller.onPrevious : null,
                    ),
                  ),
                  const SizedBox(width: 15),
                  if (!state.completed)
                    Expanded(
                      child: AppButton(title: 'Next', onTap: controller.onNext),
                    ),
                  if (state.completed)
                    Expanded(
                      child: AppButton(title: 'Start over', onTap: controller.onNext),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
