import 'package:equatable/equatable.dart';

import '../../../data/models/factoid.dart';

class QuizState extends Equatable {
  const QuizState({
    required this.factoid,
    required this.ordinalNumber,
    this.completed = false,
  });

  final Factoid? factoid;
  final int ordinalNumber;
  final bool completed;

  @override
  List<Object?> get props => [];
}
