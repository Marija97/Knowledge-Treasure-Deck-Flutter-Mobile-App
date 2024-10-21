import 'package:equatable/equatable.dart';

import '../../../data/models/factoid.dart';

class QuizState extends Equatable {
  const QuizState({
    required this.factoid,
    required this.ordinalNumber,
    this.completed = false,
    this.showHint = false,
    this.showCorrectAnswer = false,
  });

  final Factoid? factoid;
  final int ordinalNumber;
  final bool completed;
  final bool showHint;
  final bool showCorrectAnswer;

  @override
  List<Object?> get props => [];

  QuizState copyWith({
    Factoid? factoid,
    int? ordinalNumber,
    bool? completed,
    bool? showHint,
    bool? showCorrectAnswer,
  }) {
    return QuizState(
      factoid: factoid ?? this.factoid,
      ordinalNumber: ordinalNumber ?? this.ordinalNumber,
      completed: completed ?? this.completed,
      showHint: showHint ?? this.showHint,
      showCorrectAnswer: showCorrectAnswer ?? this.showCorrectAnswer,
    );
  }
}
