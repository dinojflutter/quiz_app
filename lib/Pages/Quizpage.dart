import 'package:flutter/material.dart';
import 'package:quiz_app/Component/decoration.dart';
import 'package:quiz_app/Component/question.dart';
import 'package:quiz_app/Pages/Quiz_Screen.dart';

import '../Component/ActionBotton.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Quizpage extends StatefulWidget {
  const Quizpage({super.key});

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade900,
      ),
      body: SizedBox.expand(
        child: Gradientdecoration(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "हाजिर जबाफ ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("questions")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final questiondocs = snapshot.data!.docs;
                    final questions = questiondocs
                        .map((e) => Question.fromQueryDocumentSnapshot(e))
                        .toList();

                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("configDoc")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final configDoc = snapshot.data!.docs.first.data()
                            as Map<String, dynamic>;

                        final totalTime = configDoc["key"];
                        return Column(
                          children: [
                            Actionbottom(
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Quizscreen(
                                              question: questions,
                                              totalTime: totalTime,
                                            )));
                              },
                              title: "Start",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Total No. of Question : ${questions.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
