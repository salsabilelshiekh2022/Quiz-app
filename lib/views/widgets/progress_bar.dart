import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_app/cubit/questions_cubit.dart';

import '../../constants.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});
  @override
  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

late AnimationController controller;

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionsCubit, QuestionsState>(
      listener: (context, state) {
        if (BlocProvider.of<QuestionsCubit>(context).isAnswered) {
          controller.stop();
        }
        if (BlocProvider.of<QuestionsCubit>(context).reset) {
          Future.delayed(const Duration(seconds: 1), () {
            controller.reset();
            controller.forward().whenComplete(
                () => BlocProvider.of<QuestionsCubit>(context).nextQuestion);
          });
        }
      },
      child: Container(
        height: 35,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: const Color(0xff3f4768), width: 3),
        ),
        child: Stack(children: [
          LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxWidth * animation.value,
              decoration: BoxDecoration(
                gradient: kPrimaryGradient,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${(animation.value * 60).round()} sec"),
                SvgPicture.asset("assets/images/clock.svg")
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
