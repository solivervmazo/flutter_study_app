import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<Questions>? questions;
  int questionsCount;

  QuestionPaperModel({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.description,
    required this.timeSeconds,
    required this.questions,
    required this.questionsCount,
  });

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'].toString(),
        imageUrl = json['image_url'].toString(),
        description = json['Description'].toString(),
        timeSeconds = json['time_seconds'] as int,
        questionsCount = 0,
        questions = json["questions"] != null
            ? (json["questions"] as List)
                .map((e) => Questions.fromJson(e as Map<String, dynamic>))
                .toList()
            : null;

  QuestionPaperModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot['id'].toString(),
        title = snapshot['title'].toString(),
        imageUrl = snapshot['image_url'].toString(),
        description = snapshot['Description'].toString(),
        timeSeconds = snapshot['time_seconds'] as int,
        questionsCount = snapshot['questions_count'] as int;

  String timeInMinutes() => "${(timeSeconds / 60).ceil()} mins";

  Map<String, dynamic> toJson({List<String> remove = const []}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    final List questionsToList = questions != null
        ? questions!.map((v) => v.toJson()).toList()
        : const <Map<String, dynamic>>[] as List;
    data['id'] = id;
    if (!remove.contains("title")) {
      data['title'] = title;
    }
    if (!remove.contains("image_url")) {
      data['image_url'] = imageUrl;
    }
    if (!remove.contains("Description")) {
      data['Description'] = description;
    }
    if (!remove.contains("time_seconds")) {
      data['time_seconds'] = timeSeconds;
    }
    if (!remove.contains("questions_count")) {
      data['questions_count'] = questionsToList.length;
    }
    if (!remove.contains("questions")) {
      data['questions'] = questionsToList;
    }

    return data;
  }
}

class Questions {
  String id;
  String question;
  List<Answers>? answers;
  String? correctanswer;
  String? selectedAnswer;

  Questions({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctanswer,
  });

  Questions.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        question = json["question"],
        answers = json["answers"] != null
            ? (json["answers"] as List)
                .map((e) => Answers.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
        correctanswer = json['correct_answer'];

  Questions.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot['id'].toString(),
        question = snapshot['question'].toString(),
        answers = [],
        correctanswer = snapshot['correct_answer'].toString();

  Map<String, dynamic> toJson({List<String> remove = const []}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    final List answersToList = answers != null
        ? answers!.map((v) => v.toJson()).toList()
        : const <Map<String, dynamic>>[] as List;
    data['id'] = id;
    if (!remove.contains("question")) {
      data['question'] = question;
    }
    if (!remove.contains("correct_answer")) {
      data['correct_answer'] = correctanswer;
    }
    if (!remove.contains("answers")) {
      data['answers'] = answersToList;
    }
    return data;
  }
}

class Answers {
  final String identifier;
  final String answer;

  Answers({required this.identifier, required this.answer});

  Answers.fromJson(Map<String, dynamic> json)
      : identifier = json["identifier"] as String,
        answer = json["answer"] as String;

  Answers.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'].toString(),
        answer = snapshot['answer'].toString();

  Map<String, dynamic> toJson({List<String> remove = const []}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["identifier"] = identifier;
    data["answer"] = answer;
    if (!remove.contains("answers")) {
      data['answer'] = answer;
    }
    return data;
  }
}
