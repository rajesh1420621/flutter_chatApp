import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/manage/authenticate.dart';
// import 'package:flutter_chatbot/views/SignIn.dart';
// import 'package:flutter_chatbot/views/SignUp.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Project' ,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch:Colors.blue
      ),
      home:Authenticate(),
    );
  }
}
