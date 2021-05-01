import 'package:flutter/material.dart';
import 'package:flutter_chatbot/manage/HelperFunction.dart';
import 'package:flutter_chatbot/manage/authenticate.dart';
import 'package:flutter_chatbot/manage/constant.dart';
import 'package:flutter_chatbot/services/auth.dart';
import 'package:flutter_chatbot/views/Search.dart';
// import 'package:flutter_chatbot/views/SignIn.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = AuthMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelpFunction.getUserNameSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sandesh Seva"),
        actions: [
          GestureDetector(
              onTap: () {
                authMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.logout),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
    );
  }
}
