import 'dart:convert';

class Quiz {
  final String id;
  final String title;
  final DateTime createdDate;
  final String author;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.createdDate,
    required this.author,
    required this.questions,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'createdDate': createdDate.toIso8601String(),
        'author': author,
        'questions': jsonEncode(questions.map((q) => q.toJson()).toList()),
      };

  // from json
  Quiz.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        createdDate = DateTime.parse(json['createdDate']),
        author = json['author'],
        questions = List<Question>.from(
            jsonDecode(json['questions']).map((q) => Question.fromJson(q)));
}

class Question {
  final String title;
  final List<String> choices;
  final int correctAnswerIndex;

  Question({
    required this.title,
    required this.choices,
    required this.correctAnswerIndex,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'choices': choices,
        'correctAnswerIndex': correctAnswerIndex,
      };

  // from json
  Question.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        choices = List<String>.from(json['choices']),
        correctAnswerIndex = json['correctAnswerIndex'];
}
