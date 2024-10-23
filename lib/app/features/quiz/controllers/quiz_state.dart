import 'package:equatable/equatable.dart';

import '../../../data/models/factoid.dart';

enum QuizMode { learning, testing }

class QuizState extends Equatable {
  const QuizState({
    required this.factoid,
    required this.ordinalNumber,
    this.mode = QuizMode.learning,
    required this.obtained,
    this.completed = false,
    this.showHint = false,
    this.showCorrectAnswer = false,
  });

  factory QuizState.empty() => QuizState(
        factoid: null,
        ordinalNumber: -1,
        obtained: false,
      );

  final Factoid? factoid;
  final bool obtained;
  final int ordinalNumber;
  final QuizMode mode;
  final bool completed;
  final bool showHint;
  final bool showCorrectAnswer;

  @override
  List<Object?> get props => [];

  QuizState copyWith({
    Factoid? factoid,
    int? ordinalNumber,
    QuizMode? mode,
    bool? obtained,
    bool? completed,
    bool? showHint,
    bool? showCorrectAnswer,
  }) {
    return QuizState(
      factoid: factoid ?? this.factoid,
      ordinalNumber: ordinalNumber ?? this.ordinalNumber,
      obtained: obtained ?? this.obtained,
      completed: completed ?? this.completed,
      mode: mode ?? this.mode,
      showHint: showHint ?? this.showHint,
      showCorrectAnswer: showCorrectAnswer ?? this.showCorrectAnswer,
    );
  }
}
