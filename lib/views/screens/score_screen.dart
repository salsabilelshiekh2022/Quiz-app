import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_app/constants.dart';

import '../../cubit/questions_cubit.dart';
import '../../models/questions.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/images/bg.svg',
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              const Spacer(
                flex: 3,
              ),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: kSecondaryColor),
              ),
              const Spacer(),
              BlocBuilder<QuestionsCubit, QuestionsState>(
                  builder: (context, state) {
                var cubit = BlocProvider.of<QuestionsCubit>(context);
                return Text(
                  "${cubit.numOfCorrectAns * 10}/${questions.length * 10}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: kSecondaryColor),
                );
              }),
              const Spacer(
                flex: 3,
              )
            ],
          )
        ],
      ),
    );
  }
}
