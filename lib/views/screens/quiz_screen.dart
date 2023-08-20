import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import '../../cubit/questions_cubit.dart';
import '../../models/questions.dart';
import '../widgets/progress_bar.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              BlocProvider.of<QuestionsCubit>(context).nextQuestion();
            },
            child: const Text(
              "Skip",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/bg.svg',
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: ProgressBar(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: BlocBuilder<QuestionsCubit, QuestionsState>(
                    builder: (context, state) {
                      return Text.rich(
                        TextSpan(
                            text:
                                "Question ${BlocProvider.of<QuestionsCubit>(context).selectQuestion} ",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: kSecondaryColor,
                                ),
                            children: [
                              TextSpan(
                                text: "/${questions.length}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: kSecondaryColor),
                              ),
                            ]),
                      );
                    },
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Expanded(
                  child: PageView.builder(
                      controller: BlocProvider.of<QuestionsCubit>(context)
                          .pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => QuestionCard(
                            question: questions[index],
                          ),
                      itemCount: questions.length),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
