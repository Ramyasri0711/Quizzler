import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizzler(),
          ),
        ),
      ),
    );
  }
}

class Quizzler extends StatefulWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  // List<String> questions = [
  //   'You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //       'A slug\'s blood is green.',
  // ];
  QuizBrain? q1;
  // int questionNum = 0;
  List<Icon> scoreKeeper = [];
  @override
  void initState() {
    super.initState();
    q1 = QuizBrain();
  }

  void score_riser(bool userPickedAns) {
    bool crt_ans = q1!.getAnswer(q1!.questionNum) ?? '';
    setState(() {
      if (q1!.IsFinished() == true) {
        Alert(
          context: context,
          title: "COMPLETED",
          desc: "Successfully reached the end..!",
        ).show();
        q1!.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAns == crt_ans) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        q1!.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // TextFormField(
        //   decoration: const InputDecoration(
        //     border: UnderlineInputBorder(),
        //     labelText: 'Enter your username',
        //   ),
        // ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                q1!.getQuestion(q1!.questionNum) ?? 'uhu',
                // 'q1.Q',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(15.0),
          child: TextButton(
            style: TextButton.styleFrom(
              //primary: Colors.green,
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              setState(() {
                score_riser(true);
                //q1.questionNum++;
                // q1?.nextQuestion();
              });
            },
            child: Text(
              'True',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(15.0),
          child: TextButton(
            style: TextButton.styleFrom(
              // primary: Colors.green,
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              setState(() {
                // q1!.nextQuestion();
                score_riser(false);
              });
            },
            child: Text(
              'False',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        )),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
