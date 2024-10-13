import 'package:ash/app/features/quiz/view/widgets/quiz_card.dart';
import 'package:ash/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/colors.dart';
import '../../../widgets/text.dart';
import '../controllers/quiz_controller.dart';

class QuizPage extends ConsumerWidget {
  const QuizPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          // Todo global padding
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: AppText.large(':)')),
              const Spacer(),
              state.when(
                data: (quizState) {
                  if (quizState.completed) return Text('Completed!!');
                  if (quizState.factoid == null) return Text('Some error!');
                  return Expanded(flex: 3, child: QuizCard(quizState.factoid!));
                },
                error: (error, _) => Text(error.toString()),
                loading: () => Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.primaryLight,
                  ),
                ),
              ),
              const Spacer(),
              AppButton(title: 'Next'),
            ],
          ),
        ),
      ),
    );
  }
}
