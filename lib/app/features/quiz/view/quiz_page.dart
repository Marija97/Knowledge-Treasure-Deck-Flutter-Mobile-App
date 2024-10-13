import 'package:ash/app/features/quiz/view/widgets/quiz_card.dart';
import 'package:ash/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/text.dart';
import '../controllers/quiz_controller.dart';

class QuizPage extends ConsumerWidget {
  const QuizPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(quizControllerProvider.notifier);
    final state = ref.watch(quizControllerProvider);
    Widget stateContentView;
    if (state.completed) stateContentView =  Text('Completed!!');
    else if (state.factoid == null) stateContentView = Text('Some error!');
    else stateContentView = Expanded(flex: 3, child: QuizCard(state.factoid!));
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
              stateContentView,
              const Spacer(),
              AppButton(title: 'Next', onTap: controller.onNext),
            ],
          ),
        ),
      ),
    );
  }
}