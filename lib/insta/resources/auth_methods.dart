import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nomad/insta/resources/storage_methods.dart';
import 'package:nomad/insta/models/user.dart' as model;

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User? currentUser = _auth.currentUser;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('user').doc(currentUser?.uid ?? "").get();

    return model.User.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUser({
    String? email,
    String? password,
    String? username,
    String? bio,
    Uint8List? file,
  }) async {
    String res = "Some error Occurred";
    try {
      if ((email ?? "").isNotEmpty ||
          (password ?? "").isNotEmpty ||
          (username ?? "").isNotEmpty ||
          (bio ?? "").isNotEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email ?? "",
          password: password ?? "",
        );

        String userImg = await StorageMethods()
            .uploadImageToStorage('profilePics', file ?? Uint8List(1), false);

        model.User _user = model.User(
          fullName: username,
          userId: cred.user?.uid ?? "",
          userImg: userImg,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        // adding user in our database
        await _firestore
            .collection("user")
            .doc(cred.user?.uid ?? "")
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    String? email,
    String? password,
  }) async {
    String res = "Some error Occurred";
    try {
      if ((email ?? "").isNotEmpty || (password ?? "").isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email ?? "",
          password: password ?? "",
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
