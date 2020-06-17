//import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/user.dart';

class Quiz {
  String quizId;
  String quizName;
  String quizDescription;
  String scheduledDate;
  String createdBy;
  List<Question> questions;
  Quiz({
    this.quizId,
    this.quizName,
    this.quizDescription,
    this.scheduledDate,
    this.createdBy,
    this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['questions'] as List;
    List<Question> questionList =
        list.map((i) => Question.fromJson(i)).toList();
    return Quiz(
      quizId: parsedJson['_id'],
      quizName: parsedJson['quizName'],
      quizDescription: parsedJson['quizDescription'],
      scheduledDate: parsedJson['scheduledDate'],
      createdBy: parsedJson['createdBy'],
      questions: questionList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> questions = this.questions != null
        ? this.questions.map((e) => e.toJson()).toList()
        : null;
    return {
      'quizName': this.quizName,
      'quizDescription': this.quizDescription,
      'scheduledDate': this.scheduledDate.toString(),
      'createdBy': this.createdBy,
      'questions': questions,
    };
  }
}

class Question {
  String questionId;
  String questionText;
  int marks;
  List<Option> optionList;
  String rightOption;
  Question({
    this.questionId,
    this.questionText,
    this.marks,
    this.optionList,
    this.rightOption,
  });

  factory Question.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['options'] as List;
    List<Option> options = list.map((i) => Option.fromJson(i)).toList();
    return Question(
      questionId: parsedJson['questionId'].toString(),
      questionText: parsedJson['questionText'],
      //marks: parsedJson['marks'] as int,
      optionList: options,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> options = this.optionList != null
        ? this.optionList.map((e) => e.toJson()).toList()
        : null;
    return {
      "questionId": this.questionId,
      "questionText": this.questionText,
      "marks": '2',
      "options": options,
      "rightOption": this.rightOption,
    };
  }
}

class Option {
  String optionId;
  String optionText;
  bool selected;
  Option({
    this.optionId,
    this.optionText,
    this.selected,
  });

  factory Option.fromJson(Map<String, dynamic> parsedJson) {
    return Option(
      optionId: parsedJson['optionId'],
      optionText: parsedJson['optionText'],
      selected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "optionId": this.optionId,
      "optionText": this.optionText,
    };
  }
}

class AnswerList {
  String quizId;
  String userId;
  List<Answer> answers;
  DateTime submittedDate;
  AnswerList({
    this.quizId,
    this.userId,
    this.answers,
    this.submittedDate,
  });

  Map<String, dynamic> toJson() {
    List<Map> answers = this.answers != null
        ? this.answers.map((e) => e.toJson()).toList()
        : null;
    return {
      "quizId": this.quizId,
      "userId": this.userId,
      "quizDurationInSec": 120034,
      "answers": answers
    };
  }
}

class Answer {
  String questionId;
  String selectedOptionId;
  Answer({
    this.questionId,
    this.selectedOptionId,
  });
  factory Answer.fromJson(Map<String, dynamic> parsedJson) {
    return Answer(
      questionId: parsedJson['questionId'],
      selectedOptionId: parsedJson['selectedOptionId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "questionId": this.questionId,
      "optionIdAnswered": this.selectedOptionId,
      "bonusPoint": 3
    };
  }
}

class Result {
  String totalScore;
  String result;
  Result({
    this.totalScore,
    this.result,
  });

  factory Result.fromJson(Map<String, dynamic> parsedJson) {
    return Result(
      totalScore: parsedJson['totalScore'].toString(),
      result: parsedJson['result'],
    );
  }
}
