import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chatbot/model/userData.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserData _userFromFirebaseUser(User user) {
    return user != null ? UserData(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = credential.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
    }
  }

  Future singnUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = credential.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future restPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {}
  }

  // Future UpadteUserdata(){
  //   try{
  //     return await _auth.u
  //   }
  // }
}
