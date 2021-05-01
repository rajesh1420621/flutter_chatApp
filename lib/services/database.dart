import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getuserByUserName(String username) async {
    return await FirebaseFirestore.instance
        .collection("USER")
        .where("name", isEqualTo: username)
        .get();
  }

  getuserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("USER")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("USER").add(userMap);
  }

  createChatRoom(String chatroomid, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatroomid)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.tostring);
    });
  }
}
