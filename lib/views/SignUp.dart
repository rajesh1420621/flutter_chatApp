import 'package:flutter/material.dart';
import 'package:flutter_chatbot/manage/HelperFunction.dart';
import 'package:flutter_chatbot/services/auth.dart';
import 'package:flutter_chatbot/services/database.dart';
import 'package:flutter_chatbot/views/ChatRoom_Screen.dart';
import 'package:flutter_chatbot/widget/widget.dart';

class SignUp extends StatefulWidget {
  final Function toggle;

  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isloading = false;

  AuthMethods authMethods = AuthMethods();

  DatabaseMethods databaseMethods = DatabaseMethods();

  final minimumPadding = 5.0;
  final formkey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signMeUp() {
    if (formkey.currentState.validate()) {
      setState(() {
        isloading = true;
      });
      authMethods
          .singnUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        // print("${val.uid}");
        Map<String, String> userInfoMap = {
          "name": userNameTextEditingController.text,
          "email": emailTextEditingController.text,
        };

        HelpFunction.saveUserNameSharedPreference(
            userNameTextEditingController.text);
        HelpFunction.saveUserEmailSharedPreference(
            emailTextEditingController.text);

        databaseMethods.uploadUserInfo(userInfoMap);
        HelpFunction.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarName(context),
      body: isloading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
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
                            child: Column(children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: minimumPadding,
                                      bottom: minimumPadding),
                                  child: TextFormField(
                                      controller: userNameTextEditingController,
                                      style: simpleTextStyle(),
                                      validator: (val) {
                                        return val.isEmpty || val.length < 2
                                            ? "Please Provide a valid username"
                                            : null;
                                      },
                                      decoration: textFieldInputDecoration(
                                          'username'))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: minimumPadding,
                                      bottom: minimumPadding),
                                  child: TextFormField(
                                      controller: emailTextEditingController,
                                      style: simpleTextStyle(),
                                      validator: (val) {
                                        return RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(val)
                                            ? null
                                            : 'Please provide a valid email id';
                                      },
                                      decoration:
                                          textFieldInputDecoration('email'))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: minimumPadding,
                                      bottom: minimumPadding),
                                  child: TextFormField(
                                      obscureText: true,
                                      validator: (val) {
                                        return val.length < 6
                                            ? "Please enter password with 6+ characters"
                                            : null;
                                      },
                                      controller: passwordTextEditingController,
                                      style: simpleTextStyle(),
                                      decoration:
                                          textFieldInputDecoration("password")))
                            ])),
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
                              signMeUp();
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
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            )),
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
                            'Sign Up with Google',
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have account ?",
                                style: mediumTextStyle()),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: Container(
                                child: Text("SignIn now",
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
            ),
    );
  }
}
