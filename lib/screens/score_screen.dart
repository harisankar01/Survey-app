import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controller/quiz_controller.dart';
import 'package:flutter_svg/svg.dart';

import '../controller/db.dart';

class ScoreScreen extends StatelessWidget {
  Db data=Db();
  CollectionReference users = FirebaseFirestore.instance.collection('Students');
  late int worryscore;
  late int cScore;
  late int sscore;
  ScoreScreen(this.worryscore, this.cScore, this.sscore);

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'name': data.namee,
      'Roll-no': data.rolle,
      'Concentration Disruption Score': cScore,
      'Somatic Trait Anxiety Score':sscore,
      'Worry Score':worryscore// 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Results",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              Text(
                "Worry Score= ${_qnController.Worryscore}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 1,),
              Text(
                "Concentration Disruption Score= ${_qnController.CScore}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 1,),
              Text(
                "Somatic Trait Anxiety Score = ${_qnController.Sscore}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 2),
              ElevatedButton(
                onPressed: addUser,
                child: const Text(
                  "Done",
                ),)
            ],
          )
        ],
      ),
    );
  }
}