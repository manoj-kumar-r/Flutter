import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_note_app/com/sysfore/note/demo/models/note_model.dart';
import 'package:demo_note_app/com/sysfore/note/demo/models/user_model.dart';
// import 'package:firebase/firebase.dart' if (dart.library.html) "package:firebase/firebase.dart"
//     as fb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  var _firebaseAuth = FirebaseAuth.instance;
  var _userStoreRef = FirebaseFirestore.instance.collection("manojUsers");
  var _noteStoreRef = FirebaseFirestore.instance.collection("manojNotes");
  var _firebaseStorageRef = FirebaseStorage.instance.ref("profilePics");

  static var shared = AuthenticationService();

  // Sign in
  Future<void> signIn(
      {required String email,
      required String password,
      required Function(bool, String?) onStatusChanged}) async {
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
    } on Exception catch (e) {
      onStatusChanged(false, e.toString());
    }
  }

  String getCurrentUid() {
    return _firebaseAuth.currentUser!.uid;
  }

  // add user to db
  Future<void> addUserToDB(
      {required UserModel userModel,
      required Function(bool, String) onStatusChanged}) async {
    try {
      await _userStoreRef.doc(userModel.uid).set(userModel.toMap(userModel));
      onStatusChanged(true, "Added user data");
    } on Exception catch (e) {
      onStatusChanged(false, e.toString());
    }
  }

  //Sign up process
  Future<void> signUp(
      {required String email,
      required String password,
      required Function(bool, String) onStatusChanged}) async {
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

  Future<void> uploadFile(String filePath, String fileName,
      {String fileType = ".jpg",
      required Function(bool, String) onStatusChanged}) async {
    try {
      if (kIsWeb) {
        // var metadata = fb.UploadMetadata(
        //   contentType: (fileType == ".jpg") ? "images/*" : "audio/*",
        // );
        // var file = File(filePath);
        // fb.UploadTaskSnapshot uploadTaskSnapshot = await fb
        //     .storage()
        //     .ref("noteFiles")
        //     .child("$fileName$fileType")
        //     .put(file, metadata)
        //     .future;
        // var uri = await uploadTaskSnapshot.ref.getDownloadURL();
        // print(uri);
        // onStatusChanged(true, uri.toString());
      } else {
        var file = File(filePath);
        await _firebaseStorageRef
            .child('$fileName')
            .putFile(file)
            .then((value) async => {
                  if (value != null)
                    {onStatusChanged(true, await value.ref.getDownloadURL())}
                  else
                    {onStatusChanged(false, "Upload Failed")}
                });
      }
    } on Exception catch (e) {
      onStatusChanged(false, e.toString());
    }
  }

  // get user from db
  Future<void> getUserFromDB(
      {required String uid,
      Function(bool, UserModel?, String)? onStatusChanged = null}) async {
    try {
      DocumentSnapshot doc = await _userStoreRef.doc(uid).get();
      onStatusChanged!(
          true,
          UserModel.fromMap(doc.data() as Map<String, dynamic>),
          "User Fetched");
    } on Exception catch (e) {
      onStatusChanged!(false, null, e.toString());
    }
  }

  // add note to server
  Future<void> uploadNoteToServer(
      {required NoteModel noteModel,
      required Function(bool, String) onStatusChanged}) async {
    try {
      if (noteModel.isAttached) {
        String name = noteModel.attachPath.split('/').last;
        var fileType = "";
        if (noteModel.attachType == "A") {
          fileType = ".mp3";
        } else {
          fileType = ".jpg";
        }
        await uploadFile(noteModel.attachPath, name, fileType: fileType,
            onStatusChanged: (status, message) async {
          print(status);
          print(message);
          if (status) {
            noteModel.attachName = name;
            noteModel.attachPath = message;
            await insertNoteToServer(
                noteModel: noteModel, onStatusChanged: onStatusChanged);
          } else {
            onStatusChanged(status, message);
          }
        });
      } else {
        await insertNoteToServer(
            noteModel: noteModel, onStatusChanged: onStatusChanged);
      }
    } on Exception catch (e) {
      onStatusChanged(false, e.toString());
    }
  }

  Future<void> insertNoteToServer(
      {required NoteModel noteModel,
      required Function(bool, String) onStatusChanged}) async {
    try {
      await _noteStoreRef.doc(noteModel.keyId).set(noteModel.toMap());
      onStatusChanged(true, "Added user data");
    } on Exception catch (e) {
      onStatusChanged(false, e.toString());
    }
  }

  Future<void> getNoteFromServer(
      {required String type,
      required Function(bool, String, List<NoteModel>) onStatusChanged}) async {
    print("type:$type");
    try {
      List<NoteModel> dataList = [];
      var ref = _noteStoreRef.where("userId", isEqualTo: getCurrentUid());
      if (type.length > 0) {
        ref.where("attachType", isEqualTo: type);
      }
      await ref.get().then((snapShot) {
        print(snapShot);
        snapShot.docs.forEach((result) {
          print(result);
          dataList.add(NoteModel.fromMap(result.data()));
        });
        onStatusChanged(true, "Success", dataList);
      });
    } on Exception catch (e) {
      onStatusChanged(false, e.toString(), []);
    }
  }

  //Sign Out
  Future<void> signOut(
      {required Function(bool, String) onStatusChanged}) async {
    try {
      await _firebaseAuth.signOut();
      onStatusChanged(true, "Logout Success");
    } on Exception catch (e) {
      onStatusChanged(false, e.toString());
    }
  }
}
