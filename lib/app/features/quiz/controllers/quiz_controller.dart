import 'package:ash/app/data/knowledge_repository/knowledge_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/factoid.dart';
import 'quiz_state.dart';

final quizControllerProvider = StateNotifierProvider.autoDispose
    .family<QuizController, QuizState, String>((ref, category) {
  final knowledgeRepository = ref.read(knowledgeRepositoryProvider);

  final quest = knowledgeRepository.getKnowledgeForCategory(category);
  final allObtained = knowledgeRepository.getAllObtained(category);
  final markPermanentlyAsObtained = knowledgeRepository.markAsObtained;

  final state = quest.isEmpty
      ? QuizState.empty()
      : QuizState(
          factoid: quest.first,
          ordinalNumber: 0,
          obtained: allObtained.contains(quest.first.key),
        );

  return QuizController(state, quest, allObtained, markPermanentlyAsObtained);
});

class QuizController extends StateNotifier<QuizState> {
  final List<Factoid> quest;
  final Set<String> allObtained;
  final Future<void> Function(Factoid f) markPermanentlyAsObtained;

  QuizController(
    QuizState state,
    List<Factoid> this.quest,
    Set<String> this.allObtained,
    Future<void> Function(Factoid f) this.markPermanentlyAsObtained,
  ) : super(state);

  String get progressPrint {
    return '${state.ordinalNumber + 1}/${quest.length}';
  }

  void switchQuizMode() {
    final other = QuizMode.values.firstWhere((mode) => mode != state.mode);
    state = state.copyWith(mode: other);
  }

  // static const questLength = 5; // Todo set in settings...
  bool _isObtained(Factoid factoid) {
    return allObtained.contains(factoid.key);
  }

  Future<void> markAsObtained() async {
    final factoid = state.factoid!;
    allObtained.add(factoid.key);
    await markPermanentlyAsObtained.call(factoid);
  }

  void toggleCorrectAnswerVisibility() {
    state = state.copyWith(showCorrectAnswer: !state.showCorrectAnswer);
  }

  void toggleHintVisibility() {
    state = state.copyWith(showHint: !state.showHint);
  }

  void nextView() {
    if (!state.showHint && state.factoid!.hint != null)
      toggleHintVisibility();
    else if (!state.showCorrectAnswer)
      toggleCorrectAnswerVisibility();
    else
      onNext();
  }

  bool get hasPrevious => state.ordinalNumber > 0;

  void onPrevious() {
    if (!hasPrevious) return;
    final cardNumber = state.ordinalNumber - 1;
    state = QuizState(
      factoid: quest[cardNumber],
      ordinalNumber: cardNumber,
      mode: state.mode,
      obtained: _isObtained(quest[cardNumber]),
      showHint: false,
      showCorrectAnswer: false,
    );
  }

  void onNext() {
    final cardNumber = state.ordinalNumber + 1;

    // Todo completed as a custom state
    // if (cardNumber == questLength - 1) {
    if (cardNumber >= quest.length) {
      state = state.copyWith(factoid: null, ordinalNumber: cardNumber, completed: true);
      return;
    }
    state = QuizState(
      factoid: quest[cardNumber],
      ordinalNumber: cardNumber,
      obtained: _isObtained(quest[cardNumber]),
      mode: state.mode,
    );
  }
}
