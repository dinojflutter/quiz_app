import 'package:flutter/material.dart';
import 'package:quiz_app/Component/decoration.dart';
import 'package:quiz_app/Component/question.dart';
import 'package:quiz_app/Pages/Quiz_Screen.dart';

import '../Component/ActionBotton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Quiz APP"),
      // ),
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
                      .collection("question")
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
                    return Actionbottom(
                      ontap: () {
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Quizscreen(
                                        question: questions,
                                        totaltime: 15,
                                      )));
                        }
                      },
                      title: "Start",
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
