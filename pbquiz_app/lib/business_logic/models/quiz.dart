//import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/user.dart';

class Quiz {
  String quizId;
  List<Question> questions;
  Quiz({
    this.quizId,
    this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['questions'] as List;
    List<Question> questionList =
        list.map((i) => Question.fromJson(i)).toList();
    return Quiz(
      quizId: parsedJson['quizId'],
      questions: questionList,
    );
  }
}

class Question {
  String questionId;
  String questionText;
  List<Option> optionList;
  Question({
    this.questionId,
    this.questionText,
    this.optionList,
  });

  factory Question.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['options'] as List;
    List<Option> options = list.map((i) => Option.fromJson(i)).toList();
    return Question(
      questionId: parsedJson['questionId'],
      questionText: parsedJson['questionText'],
      optionList: options,
    );
  }
}

class Option {
  String optionId;
  String optionText;
  Option({
    this.optionId,
    this.optionText,
  });

  factory Option.fromJson(Map<String, dynamic> parsedJson) {
    return Option(
      optionId: parsedJson['optionId'],
      optionText: parsedJson['optionText'],
    );
  }
}

class AnswerList {
  String quizId;
  User user;
  List<Answer> answers;
  DateTime submittedDate;
  AnswerList({
    this.quizId,
    this.user,
    this.answers,
    this.submittedDate,
  });
}

class Answer {
  String questionId;
  String selectedOptionId;
  Answer({
    this.questionId,
    this.selectedOptionId,
  });
/*
  factory Answer.fromJson(Map<String, dynamic> parsedJson) {
    return Answer(
      questionId: parsedJson['questionId'],
      selectedOptionId: parsedJson['selectedOptionId'],
    );
  }
  */
}
