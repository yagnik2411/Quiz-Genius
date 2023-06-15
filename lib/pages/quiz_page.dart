import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_genius/utils/colors.dart';
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
      backgroundColor: MyColors.lightCyan,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        backgroundColor: MyColors.mint,
        title: const Text("Quiz Genius").centered(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: Questions.questions.length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.darkCyan, width: 3),
            borderRadius: BorderRadius.circular(15),
            color: MyColors.malachite.withOpacity(0.8),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  Questions.questions[index].question,
                  style: TextStyle(
                    color: MyColors.seashall,
                    fontSize: 15,
                    fontWeight: FontWeight.values[5],
                  ),
                  textWidthBasis: TextWidthBasis.parent,
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                buttonPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: "True".text.xl.make(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MyColors.mint),
                      elevation: MaterialStateProperty.all(10),
                      fixedSize: MaterialStateProperty.all(const Size(120, 40)),
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.white)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: "False".text.xl.make(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MyColors.mint),
                      elevation: MaterialStateProperty.all(10),
                      fixedSize: MaterialStateProperty.all(const Size(120, 40)),
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.white)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
       
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [

              MyColors.malachite,
              MyColors.mint,
               MyColors.lightCyan,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: ElevatedButton(
                      onPressed: () {},
                      child: "submit".text.xl2.make(),
                      style: ButtonStyle(
                        
                        backgroundColor: MaterialStateProperty.all(MyColors.mint),
                        elevation: MaterialStateProperty.all(10),
                        
                        side: MaterialStateProperty.all(
                            const BorderSide(color: MyColors.seashall, width: 2)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15,),
                          ),
                        ),
                      ),
                    ).p12(),
        ),
      ),
    );
  }
}
