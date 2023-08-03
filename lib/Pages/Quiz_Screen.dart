import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/Component/decoration.dart';
import 'package:quiz_app/Component/question.dart';
import 'package:quiz_app/Pages/result_screen.dart';

class Quizscreen extends StatefulWidget {
  const Quizscreen({
    required this.totalTime,
    required this.question,
    Key? key,
  }) : super(key: key);

  final int totalTime;
  final List<Question> question;

  @override
  State<Quizscreen> createState() => _QuizscreenState();
}

class _QuizscreenState extends State<Quizscreen> {
  late Timer _timer;
  late int currenttime;
  int _currentindex = 0;
  String _selectedAnswer = "";
  int score = 0;

  @override
  void initState() {
    super.initState();
    currenttime = widget.totalTime;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currenttime -= 1;
      });
      if (currenttime == 0) {
        _timer.cancel();
        Pushresult();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _checkAnswerAndProceed() {
    if (_currentindex == widget.question.length - 1) {
      // If all questions are completed, navigate to the result screen
      Pushresult();
    } else {
      setState(() {
        _currentindex++;
        _selectedAnswer = "";
      });
    }
  }

  void Pushresult() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Result(
          totalTime: widget.totalTime,
          score: score,
          question: widget.question,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentquestion = widget.question[_currentindex];
    return Scaffold(
      body: Gradientdecoration(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 52,
              ),
              Stack(
                children: [
                  LinearProgressIndicator(
                    minHeight: 40,
                    color: Colors.blueGrey,
                    backgroundColor: Colors.blueGrey.shade900,
                    borderRadius: BorderRadius.circular(20),
                    value: currenttime / widget.totalTime,
                  ),
                  Center(
                    child: Text(
                      currenttime.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Question",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                currentquestion.question,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: currentquestion.answers.length,
                  itemBuilder: (context, index) {
                    final answer = currentquestion.answers[index];
                    return AnswerTile(
                      isselected: answer == _selectedAnswer,
                      CorrectAnswer: currentquestion.correctAnswer,
                      answer: answer,
                      ontap: () {
                        setState(() {
                          _selectedAnswer = answer;
                        });
                        if (answer == currentquestion.correctAnswer) {
                          score++;
                        }
                        Future.delayed(Duration(milliseconds: 300), () {
                          _checkAnswerAndProceed();
                        });
                      },
                    );
                  },
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Row(
                children: [
                  ElevatedButton(
                    child: Text("Back"),
                    onPressed: () {
                      if (_currentindex > 0) {
                        setState(() {
                          _currentindex--;
                        });
                      }
                    },
                  ),
                  Spacer(),
                  ElevatedButton(
                    child: Text("Next"),
                    onPressed: () {
                      if (_currentindex < widget.question.length - 1) {
                        setState(() {
                          _currentindex++;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerTile extends StatelessWidget {
  const AnswerTile({
    Key? key,
    required this.isselected,
    required this.answer,
    required this.CorrectAnswer,
    required this.ontap,
  }) : super(key: key);

  final bool isselected;
  final String answer;
  final String CorrectAnswer;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Cardcolor,
      elevation: 5,
      child: ListTile(
        onTap: () => ontap(),
        title: Center(
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 18,
              color: isselected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color get Cardcolor {
    if (!isselected) return Colors.white;

    if (answer == CorrectAnswer) {
      return Colors.green;
    }
    return Colors.red;
  }
}
