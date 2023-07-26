import 'package:flutter/material.dart';
import 'package:quiz_app/Component/ActionBotton.dart';
import 'package:quiz_app/Component/decoration.dart';
import 'package:quiz_app/Component/question.dart';
import 'package:quiz_app/Pages/Homepage.dart';
import 'package:quiz_app/Pages/Quiz_Screen.dart';

class Result extends StatelessWidget {
  const Result({super.key, required this.score, required this.questions});

  final int score;

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Hello"),
      // ),
      body: SizedBox.expand(
        child: Gradientdecoration(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Result : $score / ${questions.length} ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Actionbottom(
                  title: "Play Again",
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Quizscreen(
                                  totaltime: 10,
                                  question: questions,
                                )));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
