import 'package:flutter/material.dart';

import '../../model/quize.dart';

class SingleQuestionPage extends StatefulWidget {
  final Question question;

  SingleQuestionPage({required this.question});

  @override
  _SingleQuestionPageState createState() => _SingleQuestionPageState();
}

class _SingleQuestionPageState extends State<SingleQuestionPage> {
  int? selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Single Question",
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.question.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.question.choices.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Radio<int>(
                  value: index,
                  groupValue: selectedChoice,
                  onChanged: (value) {
                    setState(() {
                      selectedChoice = value;
                    });
                  },
                ),
                title: Text(widget.question.choices[index]),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Check answer logic here
              if (selectedChoice == widget.question.correctAnswerIndex) {
                //show snackbar for correct answer

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color.fromARGB(255, 45, 104, 47),
                    content: Text('Correct Answer'),
                  ),
                );
              } else {
                // Incorrect answer logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color.fromARGB(255, 119, 66, 52),
                    content: Text('Correct Answer'),
                  ),
                );
              }
            },
            child: const Text('Check Answer'),
          ),
        ],
      ),
    );
  }
}
