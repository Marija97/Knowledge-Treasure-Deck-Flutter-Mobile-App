import 'package:ash/app/features/knowledge/controllers/knowledge_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/factoid.dart';
import 'quiz_state.dart';

final quizControllerProvider = NotifierProvider<QuizController, QuizState>(
  () => QuizController(),
);

class QuizController extends Notifier<QuizState> {
  late final List<Factoid> _knowledge;

  // static const questLength = 5; // Todo set in settings...

  void markAsObtained() {
    // Todo ...
  }

  void toggleCorrectAnswerVisibility() {
    state = state.copyWith(showCorrectAnswer: !state.showCorrectAnswer);
  }

  void toggleHintVisibility() {
    state = state.copyWith(showHint: !state.showHint);
  }

  void nextView() {
    if (!state.showHint)
      toggleHintVisibility();
    else if (!state.showCorrectAnswer)
      toggleCorrectAnswerVisibility();
    else
      onNext();
  }

  void onNext() {
    final cardNumber = state.ordinalNumber + 1;

    // Todo completed as a custom state
    // if (cardNumber == questLength - 1) {
    if (cardNumber >= _knowledge.length) {
      state = QuizState(factoid: null, ordinalNumber: -1, completed: true);
      return;
    }
    state = QuizState(
      factoid: _knowledge[cardNumber],
      ordinalNumber: cardNumber,
    );
  }

  @override
  QuizState build() {
    _knowledge = ref.read(knowledgeControllerProvider).units;

    // Todo define empty QuizState
    if (_knowledge.isEmpty) return QuizState(factoid: null, ordinalNumber: -1);

    return QuizState(factoid: _knowledge.first, ordinalNumber: 0);
  }
}
