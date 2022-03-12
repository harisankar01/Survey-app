import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controller/db.dart';
import 'package:quiz_app/screens/admin.dart';
import 'package:quiz_app/screens/quiz/quiz_screen.dart';
import 'package:country_list_pick/country_list_pick.dart';
class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  late String gender="";
  String country="India";
  Db data=Db();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child:SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill) ,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    child: const Text('Admin'),
                    onPressed: () {
                      Get.to(const LoginScreen());
                    },
                  ),
                  const Spacer(flex: 2), //2/6
                  Text(
                    "Take a  Survey",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Text("Enter your information below"),
                  const Spacer(), // 1/6
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1C2341),
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    cursorColor: Color.fromRGBO(23, 200, 123, 1),
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  Row(
                    children: [
                      Radio(value: "Male", groupValue: gender, onChanged: (value){
                        setState(() {
                          gender = value.toString();
                        });
                      }),
                      const Text(
                        'Male',
                        style: TextStyle(fontSize: 16.0,color: Colors.white),
                      ),
                      Radio(value: "Female", groupValue: gender, onChanged: (value){
                        setState(() {
                          gender = value.toString();
                        });
                      }),
                      const Text(
                        'Female',
                        style: TextStyle(fontSize: 16.0,color: Colors.white),

                      ),
                      Radio(value: "Others", groupValue: gender, onChanged: (value){
                        setState(() {
                          gender = value.toString();
                        });
                        print(gender);
                      }),
                      const Text(
                        'Others',
                        style: TextStyle(fontSize: 16.0,color: Colors.white),
                      ),
                    ],
                  ),
                  TextField(
                    controller: rollController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1C2341),
                      hintText: "Age",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    cursorColor: Color.fromRGBO(23, 200, 123, 1),
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      padding:EdgeInsets.all(20),
                      height:100,
                      alignment: Alignment.center,
                      child: Card(
                        child:Padding(
                          padding: EdgeInsets.all(5),
                            child:SizedBox(
                              width:double.infinity,
                              child:CountryListPick(
                                appBar: AppBar(
                                backgroundColor: Colors.amber,
                                  title: Text('Pick your country'),
                                ),
                    theme: CountryTheme(
                      isShowFlag: true,
                      isShowTitle: true,
                      isShowCode: true,
                      isDownIcon: true,
                      showEnglishName: false,
                      labelColor: Colors.blueAccent,
                    ),
                    initialSelection: '+91',
                    onChanged: (CountryCode? code) {
                      setState(() {
                        country =(code?.name).toString();
                      });
                    },
                  ))))),
                  Spacer(),
                  // 1/6
                  InkWell(
                    onTap: () => {
                      data.init(nameController.text,rollController.text,country,gender),
                      Get.to(()=> QuizScreen())},
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(kDefaultPadding * 0.75), // 15
                      decoration: const BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "Take a survey",
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2), // it will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}