import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/manage/HelperFunction.dart';
import 'package:flutter_chatbot/services/auth.dart';
import 'package:flutter_chatbot/services/database.dart';
import 'package:flutter_chatbot/widget/widget.dart';

import 'ChatRoom_Screen.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final minimumPadding = 5.0;
  final formkey = GlobalKey<FormState>();
  bool isloading = false;
  QuerySnapshot snapshotUserInfo;

  AuthMethods authMethods = AuthMethods();

  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();

  signIn() async {
    if (formkey.currentState.validate()) {
      setState(() {
        isloading = true;
      });
      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) async {
        if (value != null) {
          HelpFunction.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
      HelpFunction.saveUserEmailSharedPreference(
          emailTextEditingController.text);

      databaseMethods
          .getuserByUserEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelpFunction.saveUserNameSharedPreference(
            snapshotUserInfo.docs[0].data()['name']);
      });
      setState(() {
        isloading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarName(context),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: formkey,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: minimumPadding, bottom: minimumPadding),
                          child: TextFormField(
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration('email'),
                            controller: emailTextEditingController,
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : 'Please provide a valid email id';
                            },
                          )),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: minimumPadding, bottom: minimumPadding),
                        child: TextFormField(
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("password"),
                          controller: passwordTextEditingController,
                          obscureText: true,
                          validator: (val) {
                            return val.length < 6
                                ? "Please enter password with 6+ characters"
                                : null;
                          },
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              "Forgot Password?",
                              style: simpleTextStyle(),
                            ))),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xFF40C4FF),
                              const Color(0xFF0091EA),
                            ]),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            const Color(0xFFE1F5FE),
                            const Color(0xFFBBDEFB),
                          ]),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have accont ?", style: mediumTextStyle()),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text("Register now",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )),
          ),
        ));
  }
}
