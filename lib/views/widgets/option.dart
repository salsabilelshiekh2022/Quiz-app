import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/questions_cubit.dart';

import '../../constants.dart';
import '../../models/questions.dart';

class Option extends StatelessWidget {
  const Option({
    super.key,
    required this.text,
    required this.index,
    required this.question,
    this.onTap,
  });
  final String text;
  final int index;
  final Question question;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<QuestionsCubit>(context);
        Color getTheRightColor() {
          if (cubit.isAnswered) {
            if (index == cubit.correctAnswer) {
              return kGreenColor;
            } else if (index == cubit.selectedAnswer &&
                cubit.selectedAnswer != cubit.correctAnswer) {
              return kRedColor;
            }
          }
          return kGrayColor;
        }

        IconData getTheRightIcon() {
          return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
        }

        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            margin: const EdgeInsets.only(top: kDefaultPadding),
            decoration: BoxDecoration(
              border: Border.all(color: getTheRightColor()),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${index + 1}. $text',
                  style: TextStyle(
                      color: BlocProvider.of<QuestionsCubit>(context)
                          .getRightColor(index),
                      fontSize: 16),
                ),
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                      color: getTheRightColor() == kGrayColor
                          ? Colors.transparent
                          : getTheRightColor(),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: getTheRightColor())),
                  child: getTheRightColor() == kGrayColor
                      ? null
                      : Icon(getTheRightIcon(), size: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
