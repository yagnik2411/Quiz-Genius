import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:quiz_genius/models/questions.dart';


class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Genius"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: Questions.questions.length,
        
        itemBuilder:(context, index) => Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade300,
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(Questions.questions[index].question,
                textWidthBasis: TextWidthBasis.parent,),
               
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                buttonPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("True"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("False"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
        ,),
    );
  }
}