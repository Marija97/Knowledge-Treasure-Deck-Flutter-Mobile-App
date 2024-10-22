import 'package:ash/app/features/knowledge/controllers/knowledge_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/factoid.dart';
import 'quiz_state.dart';

final quizControllerProvider = StateNotifierProvider.autoDispose
    .family<QuizController, QuizState, String>((ref, category) {
  final knowledgeProvider = ref.watch(knowledgeControllerProvider.notifier);
  final quest = knowledgeProvider.getQuizData(); // factoidsForThisQuiz;

  final state = quest.isEmpty
      ? QuizState.empty()
      : QuizState(factoid: quest.first, ordinalNumber: 0);

  return QuizController(state, quest);
});

class QuizController extends StateNotifier<QuizState> {
  final List<Factoid> quest;

  QuizController(QuizState state, List<Factoid> this.quest) : super(state);

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
    if (cardNumber >= quest.length) {
      state = QuizState(factoid: null, ordinalNumber: -1, completed: true);
      return;
    }
    state = QuizState(
      factoid: quest[cardNumber],
      ordinalNumber: cardNumber,
    );
  }
}
