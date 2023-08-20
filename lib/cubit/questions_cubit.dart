import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/questions.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit() : super(QuestionsInitial());

  PageController pageController = PageController();

  bool reset = false;
  bool isAnswered = false;

  late int correctAnswer;
  late int selectedAnswer = 1;
  bool isSkiped = false;
  int numOfCorrectAns = 0;
  late int selectQuestion = 1;
  checkAnswer(Question question, int selectedIndex, int id) {
    isAnswered = true;
    reset = true;
    selectQuestion = id;
    correctAnswer = question.answer;
    selectedAnswer = selectedIndex;

    if (correctAnswer == selectedAnswer) {
      numOfCorrectAns += 1;
      emit(QuestionCorrect());
    } else {
      emit(QuestionWrong());
    }

    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
      selectQuestion = id + 1;
      emit(QuestionChange());
    });
  }

  Color getRightColor(int index) {
    if (isAnswered) {
      if (index == correctAnswer) {
        return kGreenColor;
      } else if (index == selectedAnswer && selectedAnswer == correctAnswer) {
        return kRedColor;
      }
    }
    return kGrayColor;
  }

  IconData getRightIcon(int index) {
    return getRightColor(index) == kRedColor ? Icons.close : Icons.done;
  }

  nextQuestion() {
    if (selectQuestion != questions.length) {
      isAnswered = false;

      pageController.nextPage(
        duration: const Duration(seconds: 2),
        curve: Curves.ease,
      );
    } else {}
  }
}
