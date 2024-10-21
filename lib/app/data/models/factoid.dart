import 'dart:convert';

import 'package:equatable/equatable.dart';

class Factoid extends Equatable {
  final String question;
  final String correctAnswer;
  final bool obtained;
  final String? hint;
  final String? explanation;
  final String? example;

  const Factoid({
    required this.question,
    required this.correctAnswer,
    this.obtained = false,
    this.hint,
    this.explanation,
    this.example,
  });

  @override
  List<Object?> get props => <Object?>[question, correctAnswer];

  factory Factoid.fromJson(String str) => Factoid.fromMap(
        json.decode(str),
      );

  String toJson() => json.encode(_toMap());

  factory Factoid.fromMap(Map<String, dynamic> json) => Factoid(
        question: json["question"] as String,
        correctAnswer: json["correct_answer"] as String,
        obtained: json["obtained"] as bool? ?? false,
        hint: json["hint"] as String?,
        explanation: json["explanation"] as String?,
        example: json["example"] as String?,
      );

  Map<String, dynamic> _toMap() => {
        "question": question,
        "correct_answer": correctAnswer,
        "obtained": obtained,
        "hint": hint,
        "example": example,
        "explanation": explanation,
      };
}
