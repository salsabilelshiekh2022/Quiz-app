part of 'questions_cubit.dart';

abstract class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}

final class QuestionCorrect extends QuestionsState {}

final class QuestionWrong extends QuestionsState {}

final class QuestionChange extends QuestionsState {}
