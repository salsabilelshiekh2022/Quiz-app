import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/questions_cubit.dart';
import 'package:quiz_app/views/widgets/option.dart';

import '../../constants.dart';
import '../../models/questions.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      child: Column(children: [
        Text(
          question.question,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: kBlackColor),
        ),
        const SizedBox(
          height: 10,
        ),
        ...List.generate(
          question.options.length,
          (index) => Option(
              text: question.options[index],
              index: index,
              question: question,
              onTap: () {
                BlocProvider.of<QuestionsCubit>(context)
                    .checkAnswer(question, index, question.id);
              }),
        )
      ]),
    );
  }
}
