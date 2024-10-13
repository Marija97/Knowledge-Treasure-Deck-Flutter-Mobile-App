import 'package:ash/app/models/factoid.dart';
import 'package:equatable/equatable.dart';

class QuizState extends Equatable {
  const QuizState({
    required this.factoid,
    required this.ordinalNumber,
  });

  static const questLength = 5; // Todo set in settings...

  final Factoid? factoid;
  final int ordinalNumber;

  bool get completed => ordinalNumber == questLength;

  @override
  List<Object?> get props => [];
}
