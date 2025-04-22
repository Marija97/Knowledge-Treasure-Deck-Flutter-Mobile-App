import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:know_flow/app/services/network/google_sheet_manager.dart';

extension CellDataAdjustment on String {
  // when the cell is empty, API returns empty string,
  // but the adjustment sets it as null
  String? adjust() {
    final value = this.trim();
    return value.isEmpty ? null : value;
  }
}

class Factoid extends Equatable {
  final String question;
  final String correctAnswer;
  final String category;
  final String? hint;
  final String? explanation;
  final String? example;
  final String? status;
  final int? row;

  const Factoid({
    required this.question,
    required this.correctAnswer,
    required this.category,
    this.hint,
    this.explanation,
    this.example,
    this.status,
    this.row,
  });

  String get key => question;

  @override
  List<Object?> get props => <Object?>[question, correctAnswer];

  @override
  String toString() => '${row}: ${_toMap().toString()}';

  factory Factoid.fromJson(String str) => Factoid.fromMap(
        json.decode(str),
      );

  factory Factoid.fromGoogleSheetRow({
    required int row,
    required List<dynamic> data,
    required String category,
  }) =>
      Factoid(
        row: row,
        question: data[Columns.question - 1]!.toString().adjust()!,
        correctAnswer: data[Columns.answer - 1]!.toString().adjust()!,
        category: category,
        hint: data[Columns.hint - 1].toString().adjust(),
        explanation: data[Columns.explanation - 1].toString().adjust(),
        example: data[Columns.example - 1].toString().adjust(),
        status: data[Columns.status - 1].toString().adjust(),
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
        row: json["row"] as int?,
      );

  Map<String, dynamic> _toMap() => {
        "question": question,
        "correct_answer": correctAnswer,
        "category": category,
        "hint": hint,
        "example": example,
        "explanation": explanation,
        "status": status,
        "row": row,
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
    int? row,
  }) {
    return Factoid(
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      category: category ?? this.category,
      hint: hint ?? this.hint,
      explanation: explanation ?? this.explanation,
      example: example ?? this.example,
      status: status ?? this.status,
      row: row ?? this.row,
    );
  }
}
