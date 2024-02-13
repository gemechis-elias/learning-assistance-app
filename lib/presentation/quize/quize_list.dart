import 'dart:convert';

import 'package:flutter/material.dart';

import '../../model/quize.dart';
import 'add_quiz.dart';
import 'database.dart';
import 'list_card.dart';

class QuizList extends StatefulWidget {
  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  List<Map<String, dynamic>> quizzes = [];

  @override
  void initState() {
    super.initState();
    loadQuizzes();
  }

  void loadQuizzes() async {
    final fetchedQuizzes = await DatabaseHelper.instance.fetchAllQuizzes();
    setState(() {
      quizzes = fetchedQuizzes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz List',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              // Show confirmation dialog before clearing the database
              final confirm = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm'),
                        content: const Text(
                            'Are you sure you want to clear all quizzes?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Delete'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  ) ??
                  false; // If dialog returns null (dismissed), default to false

              if (confirm) {
                await DatabaseHelper.instance.deleteAllQuizzes();
                // Clear the quizzes list in the UI and refresh
                setState(() {
                  quizzes.clear();
                });
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          List<Question> quizQuestions = [];
          try {
            final questionsData =
                json.decode(quizzes[index]['questions'].toString());
            quizQuestions = (questionsData as List)
                .map((q) => Question.fromJson(q))
                .toList();
          } catch (e) {
            print("Error decoding questions: $e");
          }

          return CardList(
            id: int.parse(quizzes[index]['id'].toString()),
            title: quizzes[index]['title'].toString(),
            author: quizzes[index]['author'].toString(),
            createdDate:
                DateTime.parse(quizzes[index]['createdDate'].toString()),
            quizQuestions: quizQuestions,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => QuizCreationPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
