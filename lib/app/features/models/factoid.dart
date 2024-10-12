import 'package:equatable/equatable.dart';

class Factoid extends Equatable {
  final String question;
  final String correctAnswer;
  final bool obtained;

  const Factoid({
    required this.question,
    required this.correctAnswer,
    required this.obtained,
  });

  @override
  List<Object?> get props => <Object?>[question, correctAnswer];
}
