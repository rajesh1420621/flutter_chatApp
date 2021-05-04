import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/manage/HelperFunction.dart';
import 'package:flutter_chatbot/manage/constant.dart';
import 'package:flutter_chatbot/services/database.dart';
import 'package:flutter_chatbot/widget/widget.dart';

import 'Conversation_Screen.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

// String _myName;

class _SearchState extends State<Search> {
  TextEditingController searchTextEditingController =
      new TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();

  QuerySnapshot searchSnapshot;

  intiateSearch() {
    databaseMethods
        .getuserByUserName(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(
                userEmail: searchSnapshot.docs[index].data()["name"],
                userName: searchSnapshot.docs[index].data()["email"],
              );
            })
        : Container();
  }

  createChatRoomAndConversation(String userName) {
    if (userName != Constants.myName) {
      List<String> users = [userName, Constants.myName];
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId,
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConversationScreen()));
    } else {
      print("You cannot send message");
    }
  }

  Widget searchTile({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: simpleTextStyle(),
              ),
              Text(
                userEmail,
                style: simpleTextStyle(),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndConversation(userName);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Message",
                style: mediumTextStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }

  // @override
  // void initState() {
  //   getUserInfo();
  //   super.initState();
  // }
  //
  // getUserInfo() async {
  //   _myName = await HelpFunction.getUserNameSharedPreference();
  //   setState(() {});
  //   print("${_myName}");
  // }
// return searchSnapshot != null
// ? ListView.builder(
//  itemCount: searchSnapshot.docs.length,
// shrinkWrap: true,
// itemBuilder: (context, index) {
//   return SearchTile(
//     userEmail: searchSnapshot.docs[index].data()["name"],
//     userName: searchSnapshot.docs[index].data()["email"],
//   );
// })
// : Container();
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarName(context),
      body: Container(
          child: Column(
        children: [
          Row(children: [
            SizedBox(
              height: 65,
            ),
            Expanded(
              child: TextField(
                  controller: searchTextEditingController,
                  decoration: InputDecoration(
                      hintText: "search username",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)))),
            ),
            GestureDetector(
              onTap: () {
                intiateSearch();
              },
              child: Container(
                height: 50,
                width: 50,
                // decoration: BoxDecoration(
                //     gradient: LinearGradient(colors: [
                //
                // ])),
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Icon(Icons.search_outlined),
              ),
            )
          ]),
          searchList(),
        ],
      )),
    );
  }
}
