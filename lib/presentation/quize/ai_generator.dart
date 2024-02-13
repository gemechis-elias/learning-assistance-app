import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/quize.dart';

Future<List<Question>> generateWithAI(String topic, String maxQuestions) async {
  const String apiKey = '';
  const String url = 'https://api.openai.com/v1/chat/completions';

  var prompt =
      "Generate a multiple choice questions quiz based in $topic topic and with the maximum amount of $maxQuestions questions, one question will have 4 choices with correct_answer(index). and send me an answer in JSON format. all question and answer is text based no formula no number. DON'T FORGET SEND THE ANSWER AS JSON AND DON'T TALK ANY THING and START THE JSON WITH {\n \"questions..";

  var response = await http.post(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": prompt},
          {"role": "user", "content": "Generate Json"}
        ]
      }));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    String textResponse = jsonResponse['choices'][0]['message']['content'];

    // Directly parse the JSON content from the response
    var questionsJson = jsonDecode(textResponse)['questions'];

    List<Question> questions =
        List<Question>.from(questionsJson.map((question) {
      int correctAnswerIndex = question['correct_answer'];
      return Question(
          title: question['question'],
          choices: List<String>.from(question['choices'].map((choice) => choice
              .toString()
              .substring(
                  3))), // Extract choice text, removing "A) ", "B) ", etc.
          correctAnswerIndex: int.parse(
                correctAnswerIndex.toString(),
              ) -
              1);
    }));

    return questions;
  } else {
    throw Exception('Failed to load questions from OpenAI');
  }
}
