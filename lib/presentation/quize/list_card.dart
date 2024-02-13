import 'dart:developer';

import 'package:assistant_app/model/quize.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final int id;
  final String title;
  final String author;
  final DateTime createdDate;
  final List<Question> quizQuestions;

  const CardList({
    Key? key,
    required this.id,
    required this.title,
    required this.author,
    required this.createdDate,
    required this.quizQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (id == 0) {
      return Container();
    } else {
      return GestureDetector(
        onTap: () {
          log("Clicked on task $id, title $title");
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => SingleQuestionPage(
          //       question: quizQuestions[i],
          //     ),
          //   ),
          // );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(59, 60, 61, 0.062),
                blurRadius: 5,
                offset: Offset(-2, 2),
              ),
            ],
          ),
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    title[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Add spacing between title and description
                      const SizedBox(height: 5),
                      Text(
                        "Questions: ${quizQuestions.length}, Author: $author",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                const SizedBox(
                    width:
                        10), // Add some spacing to the right of the last widget
              ],
            ),
          ),
        ),
      );
    }
  }
}
