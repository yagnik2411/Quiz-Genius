import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz_genius/models/scores.dart';
import 'package:quiz_genius/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({Key? key}) : super(key: key);

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
        itemCount: Scores.scores.length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.darkCyan, width: 3),
            borderRadius: BorderRadius.circular(15),
            color: MyColors.malachite.withOpacity(0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quiz Date:${DateFormat(' dd / MM / yyyy ').format(Scores.scores[index].date)}",
                style: TextStyle(
                  color: MyColors.seashall,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
                textWidthBasis: TextWidthBasis.parent,
              ).px12().py(4),
              Divider(
                color: MyColors.darkCyan,
                thickness: 2,
              ),
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: MyColors.seashall,
                  ).pOnly(left: 12),
                  Text(
                    "Correct: ${Scores.scores[index].correct} ",
                    style: TextStyle(
                      color: MyColors.seashall,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    textWidthBasis: TextWidthBasis.parent,
                  ).py(4).pOnly(right: 12),
                  const Spacer(),
                  Text(
                    "Prcent: ${Scores.scores[index].scoreInPercent}% ",
                    style: TextStyle(
                      color: MyColors.seashall,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    textWidthBasis: TextWidthBasis.parent,
                  ).px12().py(4),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
