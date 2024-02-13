import 'dart:developer';

import 'package:flutter/material.dart';

import '../../model/quize.dart';

class SingleListCard extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final bool isCompleted;

  final Function(DateTime) onDateSelected;
  final DateTime createdDate;
  final List<Question> quizQuestions;

  const SingleListCard({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.onDateSelected,
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => TaskDetail(
          //       taskId: id,
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
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  margin: const EdgeInsets.only(right: 5, bottom: 20),
                  child: Text(
                    // selectedDate.toString().substring(0, 10),
                    // human readable date format
                    "${createdDate.day}/${createdDate.month}/${createdDate.year}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 126, 127, 135),
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  width: 3,
                  height: 50,
                  color: isCompleted
                      ? const Color.fromARGB(175, 244, 67, 54)
                      : Color.fromARGB(139, 88, 186, 91),
                ),
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
