import 'dart:convert';

import 'package:equatable/equatable.dart';

class Factoid extends Equatable {
  final String question;
  final String correctAnswer;
  final bool obtained;
  final String category;
  final String? hint;
  final String? explanation;
  final String? example;

  const Factoid({
    required this.question,
    required this.correctAnswer,
    required this.category,
    this.obtained = false,
    this.hint,
    this.explanation,
    this.example,
  });

  String get key => question;

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
        category: json["category"] as String,
        hint: json["hint"] as String?,
        explanation: json["explanation"] as String?,
        example: json["example"] as String?,
      );

  Map<String, dynamic> _toMap() => {
        "question": question,
        "correct_answer": correctAnswer,
        "obtained": obtained,
        "category": category,
        "hint": hint,
        "example": example,
        "explanation": explanation,
      };

  Factoid copyWith({
    String? question,
    String? correctAnswer,
    bool? obtained,
    String? category,
    String? hint,
    String? explanation,
    String? example,
  }) {
    return Factoid(
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      obtained: obtained ?? this.obtained,
      category: category ?? this.category,
      hint: hint ?? this.hint,
      explanation: explanation ?? this.explanation,
      example: example ?? this.example,
    );
  }
}
