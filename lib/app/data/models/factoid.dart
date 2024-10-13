import 'dart:convert';

import 'package:equatable/equatable.dart';

class Factoid extends Equatable {
  final String question;
  final String correctAnswer;
  final bool obtained;

  const Factoid({
    required this.question,
    required this.correctAnswer,
    this.obtained = false,
  });

  @override
  List<Object?> get props => <Object?>[question, correctAnswer];

  factory Factoid.fromJson(String str) => Factoid.fromMap(
        json.decode(str),
      );

  String toJson() => json.encode(_toMap());

  factory Factoid.fromMap(Map<String, dynamic> json) => Factoid(
        question: json["question"],
        correctAnswer: json["correctAnswer"],
        obtained: json["obtained"] as bool,
      );

  Map<String, dynamic> _toMap() => {
        "question": question,
        "correctAnswer": correctAnswer,
        "obtained": obtained,
      };
}
