import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbot/manage/constant.dart';
import 'package:flutter_chatbot/services/database.dart';
import 'package:flutter_chatbot/widget/widget.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

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
              return SearchTile(
                userEmail: searchSnapshot.docs[index].data()["name"],
                userName: searchSnapshot.docs[index].data()["email"],
              );
            })
        : Container();
  }

  createChatRoomAndConversation(String userName) {
    String chatRoomId = getChatRoomId(userName, Constants.myName);
    List<String> users = [userName, Constants.myName];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId,
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
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

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;

  SearchTile({this.userName, this.userEmail});

  @override
  Widget build(BuildContext context) {
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
            onTap: () {},
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
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
