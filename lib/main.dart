import 'package:flutter/material.dart';
import './quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  List<Widget> counterKeeper = [];
  int counter = 0;

  void quizCheck(bool answer) {
    bool correctAnswer = quizBrain.getaAnswer();
    if (quizBrain.endOfQuestion() == counter) {
      print(counter);
      setState(() {
        if (correctAnswer == answer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }
        quizBrain.nextQuestion();

        // to print question number
        counterKeeper.add(Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Text(
            '${counter + 1}',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
        ));
        counter++;
      });
    } else {
      Alert(context: context, title: "Pratik's Que Bank", desc: "End of question")
          .show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          // flex: 3,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                quizCheck(true);
              },
            ),
          ),
        ),
        Expanded(
          // flex: 3,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                quizCheck(false);
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: counterKeeper,
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
