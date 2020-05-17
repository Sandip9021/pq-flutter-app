import 'package:pbquiz_app/business_logic/models/quiz.dart';

class WebApiService {
  Future<Quiz> fetchQuiz() {
    return Future.delayed(
        Duration(seconds: 1), () => new Quiz.fromJson(quizJSON));
  }

  Quiz fakeFetchQuiz() {
    return Quiz.fromJson(quizJSON);
  }

  void submitAnswer(AnswerList answerList) {
    print("Submitted successfully!");
  }
}

const quizJSON = {
  "quizId": "1001",
  "questions": [
    {
      "questionId": "1",
      "questionText":
          "How many roads must a man walk down before you can call him a man?",
      "options": [
        {"optionId": "a", "optionText": "10"},
        {"optionId": "b", "optionText": "12"},
        {"optionId": "c", "optionText": "32"},
        {"optionId": "d", "optionText": "22"}
      ]
    },
    {
      "questionId": "2",
      "questionText": "Who is the Prime minister of UK?",
      "options": [
        {"optionId": "a", "optionText": "Boris Jhonson"},
        {"optionId": "b", "optionText": "Angela Markel"},
        {"optionId": "c", "optionText": "Theresa May"},
        {"optionId": "d", "optionText": "Donald Trump"}
      ]
    },
    {
      "questionId": "3",
      "questionText": "Who is the Prime minister of India?",
      "options": [
        {"optionId": "a", "optionText": "Manmohan Singh"},
        {"optionId": "b", "optionText": "Narendra Modi"},
        {"optionId": "c", "optionText": "Rahul Gandhi"},
        {"optionId": "d", "optionText": "Sashi Tharoor"}
      ]
    }
  ]
};
