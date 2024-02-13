import 'package:assistant_app/presentation/quize/ai_generator.dart';
import 'package:assistant_app/presentation/quize/sigle_question.dart';
import 'package:flutter/material.dart';
import 'package:textfields/textfields.dart';

import '../../model/quize.dart';
import 'database.dart';

class QuizCreationPage extends StatefulWidget {
  @override
  _QuizCreationPageState createState() => _QuizCreationPageState();
}

class _QuizCreationPageState extends State<QuizCreationPage> {
  TextEditingController quizNameController = TextEditingController();
  TextEditingController questionTitleController = TextEditingController();
  TextEditingController choiceController = TextEditingController();
  TextEditingController generateController = TextEditingController();
  TextEditingController maxQuestionController = TextEditingController();

  TextEditingController correctIndexController = TextEditingController();

  List<Question> quizQuestions = [];
  List<String> choices = [];
  bool isGenerating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz',
            style: TextStyle(fontWeight: FontWeight.bold)),
        // ios back arrow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleTextFieldWithBorder(
                controller: quizNameController,
                autofocus: true,
                label: 'Quiz Name',
                bordercolor: const Color.fromARGB(64, 116, 116, 116),
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Add Questions ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 95, 95, 97))),

                  // Create Add icon rounded border button
                  IconButton(
                    onPressed: () {
                      // Creating a new question
                      _showAddQuestionDialog();
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    iconSize: 25.0, // Set the size as needed
                    tooltip: 'Add Question',
                  )
                ],
              ),

              const SizedBox(height: 8),
              _buildQuestionInput(),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showAddChoiceDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          const Color.fromARGB(255, 9, 36, 58), // Text color
                      elevation: 5, // Shadow depth
                      shadowColor:
                          Colors.black.withOpacity(0.5), // Shadow color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10), // Padding inside the button
                    ),
                    child: const Text('Add Choice'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Add the question to the quiz
                      _addCurrentQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          const Color.fromARGB(255, 9, 36, 58), // Text color
                      elevation: 5, // Shadow depth
                      shadowColor:
                          Colors.black.withOpacity(0.5), // Shadow color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10), // Padding inside the button
                    ),
                    child: const Text('Done'),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Show the list of titles questions
              const Center(
                child: Text('All Questions Created',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 95, 95, 97))),
              ),
              const SizedBox(height: 8),
              _buildListOfCreatedQuestions(),
              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton.icon(
                  icon: Image.asset('assets/images/bard_icon.png',
                      width: 24, height: 24), // Adjust size as needed
                  label: const Text('Generate with AI'),
                  onPressed: () {
                    _showGenerateDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        const Color.fromARGB(255, 9, 36, 58), // Text color
                    elevation: 5, // Shadow depth
                    shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10), // Padding inside the button
                    minimumSize: const Size(double.infinity,
                        48), // Make the button take the full width
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0), // Adjust the padding as needed
                child: ElevatedButton.icon(
                  label: const Text('Upload Quiz        '),
                  icon: const Icon(Icons.upload),
                  onPressed: () {
                    _uploadQuiz();
                    // show snackbar with success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Quiz Uploaded Successfully'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        const Color.fromARGB(255, 9, 36, 58), // Text color
                    elevation: 5, // Shadow depth
                    shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10), // Padding inside the button
                    minimumSize: const Size(double.infinity,
                        48), // Make the button take the full width
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListOfCreatedQuestions() {
    // Check if quizQuestions is empty

    if (quizQuestions.isEmpty && !isGenerating) {
      return const Center(
        child: Text('No Question Created yet'),
      );
    }

    if (isGenerating) {
      return const Center(
        child: Column(
          children: [
            Text('Generating Questions...'),
            CircularProgressIndicator(),
          ],
        ),
      );
    }

    return Column(
      children: [
        for (int i = 0; i < quizQuestions.length; i++)
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200], // Light grey background
              borderRadius:
                  BorderRadius.circular(5), // Optional: Rounded corners
            ),
            margin:
                const EdgeInsets.all(8), // Add some space around each question
            child: ListTile(
              title: Text('Question ${i + 1}'),
              subtitle: Text(quizQuestions[i].title),
              trailing: IconButton(
                icon: Icon(Icons.close), // "X" icon
                onPressed: () {
                  setState(() {
                    // Remove the question from the list
                    quizQuestions.removeAt(i);
                  });
                },
              ),
              onTap: () {
                // Navigate to the question page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SingleQuestionPage(
                      question: quizQuestions[i],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildQuestionInput() {
    return Column(
      children: [
        SimpleTextFieldWithBorder(
          controller: questionTitleController,
          label: 'Question Title',
          bordercolor: const Color.fromARGB(64, 116, 116, 116),
        ),
        const SizedBox(height: 8),
        SimpleTextFieldWithBorder(
          controller: correctIndexController,
          label: 'Correct Answer',
          bordercolor: const Color.fromARGB(64, 116, 116, 116),
        ),
        const SizedBox(height: 8),
        _buildChoicesInput(),
      ],
    );
  }

  Widget _buildChoicesInput() {
    return Column(
      children: [
        for (int i = 0; i < choices.length; i++)
          ListTile(
            title: Text('Choice ${i + 1}'),
            subtitle: Text(choices[i]),
          ),
      ],
    );
  }

  void _showGenerateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Generate with AI'),
          content: Container(
            height: 250,
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                TextField(
                  controller: generateController,
                  decoration: const InputDecoration(
                      labelText: 'What topic you want to generate'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: maxQuestionController,
                  decoration: const InputDecoration(
                      labelText: 'how many question you want'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isGenerating = true;
                    });
                    print(
                        'Generating ${maxQuestionController.text} questions...');
                    generateWithAI(
                            generateController.text, maxQuestionController.text)
                        .then((questions) {
                      // add the generated questions to the list
                      setState(() {
                        quizQuestions.addAll(questions);
                        isGenerating = false;
                      });
                      print('✅ Questions Generated');
                    }).catchError((error) {
                      print("Error generating questions: $error");
                      // show snackbar with error message

                      SnackBar snackBar = SnackBar(
                        content: Text('Error generating questions: $error'),
                        duration: const Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });

                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('Generate'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddChoiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Choices'),
          content: Container(
            height: 200,
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: choiceController,
                  decoration: const InputDecoration(labelText: 'Choice'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Add the choice to current question
                      choices.add(choiceController.text);
                      choiceController.clear();
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('Add Choice'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddQuestionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Question'),
          content: Column(
            children: [
              TextField(
                controller: questionTitleController,
                decoration: const InputDecoration(labelText: 'Question Title'),
              ),
              TextField(
                controller: correctIndexController,
                decoration: const InputDecoration(
                    labelText: 'Correct Answer Index (Default is 0)'),
                // 0 by default
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Close the dialog and add current question
                  Navigator.pop(context);
                  _addCurrentQuestion();
                },
                child: const Text('Add Question'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addCurrentQuestion() {
    setState(() {
      quizQuestions.add(Question(
        title: questionTitleController.text,
        choices: List.from(choices),
        correctAnswerIndex: int.tryParse(correctIndexController.text) ?? 0,
      ));
      questionTitleController.clear();
      correctIndexController.clear();
      choices.clear();
    });
  }

  void _uploadQuiz() async {
    final quiz = Quiz(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: quizNameController.text,
      createdDate: DateTime.now(),
      author: 'User',
      questions: quizQuestions,
    );

    await DatabaseHelper.instance.createQuiz(quiz);
    print('Quiz Uploaded');
  }
}
