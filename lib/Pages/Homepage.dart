import 'package:flutter/material.dart';
import 'package:quiz_app/Component/ActionBotton.dart';
import 'package:quiz_app/Pages/Quizpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Quiz App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Card(
                  elevation: 6,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Image.network(
                            "https://images.ctfassets.net/u4vv676b8z52/3rguHIe6cToCtT2lQ91aCr/d6171dc5e5cfeb0a45b5d991a1e62f38/color-blind-red-green-330x330.png?fm=jpg&q=80",
                            cacheHeight: 150,
                            cacheWidth: 150),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Written Exam test",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
