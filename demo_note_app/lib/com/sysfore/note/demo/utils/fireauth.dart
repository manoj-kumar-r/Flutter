import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_note_app/com/sysfore/note/demo/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  var _firebaseAuth = FirebaseAuth.instance;
  var _userStoreRef = FirebaseFirestore.instance.collection("manojusers");

  static var shared = AuthenticationService();

  // Sign in
  Future<void> signIn(
      {String email,
      String password,
      Function(bool, String) onStatusChanged}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      onStatusChanged(true, "Signed In");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onStatusChanged(false, 'User does not exit.');
      } else if (e.code == 'wrong-password') {
        onStatusChanged(false, 'Check user credentials.');
      } else {
        onStatusChanged(false, e.message);
      }
    }
  }

  String getCurrentUid(){
    return _firebaseAuth.currentUser.uid;
  }

  Future<void> signUp({String email, String password, Function(bool, String) onStatusChanged}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      onStatusChanged(true, "Signed Up");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onStatusChanged(false, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        onStatusChanged(false, "The account already exists for that email.");
      } else {
        onStatusChanged(false, "failure in registration");
      }
    } on Exception catch (e) {
      onStatusChanged(false, e.toString());
    }
  }

  // add user to db
  Future<void> addUserToDB(
      {UserModel userModel,
      Function(bool, String) onStatusChanged}) async {
    try {
      await _userStoreRef.doc(userModel.uid).set(userModel.toMap(userModel));
      onStatusChanged(true, "Added user data");
    }  on Exception catch (e) {
      onStatusChanged(false, e.toString());
    }
  }

  // get user from db
  Future<void> getUserFromDB(
      {String uid, Function(bool, UserModel, String) onStatusChanged}) async {
    try {
      DocumentSnapshot doc = await _userStoreRef.doc(uid).get();
      onStatusChanged(true, UserModel.fromMap(doc.data()), "User Fetched");
    }  on Exception catch (e) {
      onStatusChanged(false, null,e.toString());
    }
  }

  //Sign Out
  Future<void> signOut({Function(bool, String) onStatusChanged}) async {
    try {
      await _firebaseAuth.signOut();
      onStatusChanged(true, "Logout Success");
    } on Exception catch (e) {
      onStatusChanged(false, e.toString());
    }
  }
}
