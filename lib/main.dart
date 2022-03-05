import 'package:get/get.dart';
import 'package:quiz_app/screens/admin.dart';
import 'package:quiz_app/screens/dashboard.dart';
import 'package:quiz_app/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz/quiz_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz app',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      key : ValueKey(Get.key),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page:() =>WelcomeScreen()),
        GetPage(name: '/admin', page: ()=>const LoginScreen()),
        GetPage(name: '/quiz', page: ()=>const QuizScreen()),
        GetPage(name: '/dashboard', page: ()=>const Dashboard())
      ],
      routes: {
        '/': (context) => WelcomeScreen(),
        '/admin': (context) => const LoginScreen(),
      },
    );
  }
}