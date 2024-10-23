import 'package:ash/app/features/quiz/view/widgets/quiz_card.dart';
import 'package:ash/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/text.dart';
import '../controllers/quiz_controller.dart';

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
              Center(child: AppText.large('${state.mode.name} :)')),
              const Spacer(),
              QuizCard(category),
              const SizedBox(height: 15),
              Text(controller.progressPrint),
              const Spacer(),
              AppButton(title: 'Switch mode', onTap: controller.switchQuizMode),
              const SizedBox(height: 15),
              AppButton(title: 'Next', onTap: controller.onNext),
            ],
          ),
        ),
      ),
    );
  }
}
