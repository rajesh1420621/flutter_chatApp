import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/manage/HelperFunction.dart';
import 'package:flutter_chatbot/manage/authenticate.dart';
import 'package:flutter_chatbot/views/ChatRoom_Screen.dart';

// import 'package:flutter_chatbot/views/SignIn.dart';
// import 'package:flutter_chatbot/views/SignUp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelpFunction.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Project',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, primarySwatch: Colors.blue),
      home: userLoggedIn != null
          ? userLoggedIn
              ? ChatRoom()
              : Authenticate()
          : Container(
              child: Center(
                child: Authenticate(),
              ),
            ),
    );
  }
}
