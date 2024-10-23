import 'package:ash/app/data/knowledge_repository/knowledge_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/factoid.dart';
import 'quiz_state.dart';

final quizControllerProvider = StateNotifierProvider.autoDispose
    .family<QuizController, QuizState, String>((ref, category) {
  final knowledgeRepository = ref.read(knowledgeRepositoryProvider);

  final _quest = knowledgeRepository.getKnowledgeForCategory(category);
  final allObtained = knowledgeRepository.getAllObtained(category);

  final quest = <Factoid>[];
  for (final factoid in _quest) {
    quest.add(factoid.copyWith(obtained: allObtained.contains(factoid.key)));
  }

  final markPermanentlyAsObtained = knowledgeRepository.markAsObtained;

  final state = quest.isEmpty
      ? QuizState.empty()
      : QuizState(factoid: quest.first, ordinalNumber: 0);

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
    return '${state.ordinalNumber + 1}/${quest.length - allObtained.length + 1}';
  }

  void switchQuizMode() {
    final other =
        state.mode == QuizMode.testing ? QuizMode.learning : QuizMode.testing;
    state = state.copyWith(mode: other);
  }

  // static const questLength = 5; // Todo set in settings...
  bool _isObtained() {
    final obtained = allObtained.contains(state.factoid!.key);
    assert(obtained == state.factoid!.obtained, 'data mismatch');
    return obtained;
  }

  Future<void> markAsObtained() async {
    final factoid = state.factoid!;
    allObtained.add(factoid.key);
    state = state.copyWith(factoid: factoid.copyWith(obtained: true));
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
      showHint: false,
      showCorrectAnswer: false,
    );
  }

  void onNext() {
    final cardNumber = state.ordinalNumber + 1;

    // Todo completed as a custom state
    // if (cardNumber == questLength - 1) {
    if (cardNumber >= quest.length) {
      state = state.copyWith(factoid: null, ordinalNumber: -1, completed: true);
      return;
    }
    state = QuizState(
      factoid: quest[cardNumber],
      ordinalNumber: cardNumber,
      mode: state.mode,
    );
  }
}
