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
        .collection("ChatRoom")
        .doc(chatroomid)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.tostring);
    });
  }

  addConversationMessages(String ChatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(ChatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String ChatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(ChatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  getChatRooms(String userName) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
