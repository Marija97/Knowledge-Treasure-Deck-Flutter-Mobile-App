import 'dart:convert';

import 'package:equatable/equatable.dart';

class Factoid extends Equatable {
  final String question;
  final String correctAnswer;
  final String category;
  final String? hint;
  final String? explanation;
  final String? example;
  final String? status;

  const Factoid({
    required this.question,
    required this.correctAnswer,
    required this.category,
    this.hint,
    this.explanation,
    this.example,
    this.status,
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
        category: json["category"] as String,
        hint: json["hint"] as String?,
        explanation: json["explanation"] as String?,
        example: json["example"] as String?,
        status: json["status"] as String?,
      );

  Map<String, dynamic> _toMap() => {
        "question": question,
        "correct_answer": correctAnswer,
        "category": category,
        "hint": hint,
        "example": example,
        "explanation": explanation,
        "status": status,
      };

  Factoid copyWith({
    String? question,
    String? correctAnswer,
    bool? obtained,
    String? category,
    String? hint,
    String? explanation,
    String? example,
    String? status,
  }) {
    return Factoid(
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      category: category ?? this.category,
      hint: hint ?? this.hint,
      explanation: explanation ?? this.explanation,
      example: example ?? this.example,
      status: status ?? this.status,
    );
  }
}
