import 'dart:async';

import 'package:ash/app/models/factoid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'quiz_state.dart';

final quizControllerProvider =
    AutoDisposeAsyncNotifierProvider<QuizController, QuizState>(
  () => QuizController(),
);

class QuizController extends AutoDisposeAsyncNotifier<QuizState> {
  @override
  FutureOr<QuizState> build() {
    final defaultFactoid = Factoid(question: 'Q0', correctAnswer: 'A0');
    return QuizState(factoid: defaultFactoid, ordinalNumber: 0);
  }
}
