import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/knowledge_repository/knowledge_repository.dart';
import '../../../data/models/factoid.dart';
import 'quiz_state.dart';

final quizControllerProvider = StateNotifierProvider.autoDispose
    .family<QuizController, QuizState, String>((ref, category) {
  final knowledgeRepository = ref.read(knowledgeRepositoryProvider);

  final quest = knowledgeRepository.getKnowledgeForCategory(category);
  final allObtained = knowledgeRepository.getAllObtained(category);
  final markPermanentlyAsObtained = knowledgeRepository.markAsObtained;

  assert(quest.isNotEmpty, 'No data received');

  // show only unlearned factoids
  // Todo revise this decision
  final filteredQuest = quest.where(
    (f) => !allObtained.contains(f.key),
  ).toList().cast<Factoid>();

  // assert(filteredQuest.isNotEmpty, 'No data to learn in this category');
  QuizState initialState;
  if(filteredQuest.isEmpty) {
    initialState = QuizState.revisitedAfterCompleted();
  }
  else {
    filteredQuest.shuffle(Random());
    initialState = QuizState(
      factoid: filteredQuest.first,
      ordinalNumber: 0,
      obtained: allObtained.contains(filteredQuest.first.key),
    );
  }

  //if (category == 'articles' || category.startsWith('irregular_verbs)')) {

  //}

  return QuizController(
    initialState,
    filteredQuest,
    allObtained,
    markPermanentlyAsObtained,
  );
});

class QuizController extends StateNotifier<QuizState> {
  List<Factoid> quest;
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

  void switchQuizMode(QuizMode targetMode) {
    if(targetMode == state.mode) return;
    state = state.copyWith(mode: targetMode);
  }

  // static const questLength = 5; // Todo set in settings...
  bool _isObtained(Factoid factoid) {
    return allObtained.contains(factoid.key);
  }

  Future<void> markAsObtained() async {
    final factoid = state.factoid!;
    allObtained.add(factoid.key);
    state = state.copyWith(obtained: true);
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
      showHint: true,
      showCorrectAnswer: true,
    );
  }

  void onNext() {
    int cardNumber = state.ordinalNumber + 1;
    if (state.completed) {
      cardNumber = 0;
      final nextIteration = <Factoid>[];
      for (final factoid in quest) {
        if (!_isObtained(factoid)) nextIteration.add(factoid);
      }
      // Todo maybe shuffle?
      quest = nextIteration..shuffle();
    }

    // Todo completed as a custom state
    // if (cardNumber == questLength - 1) {
    if (cardNumber >= quest.length) {
      state = state.copyWith(
        factoid: null,
        ordinalNumber: cardNumber,
        completed: true,
      );
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
