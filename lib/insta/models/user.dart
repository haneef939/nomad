import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? email;
  final String? userId;
  final String? userImg;
  final String? fullName;
  final String? bio;
  final List? followers;
  final List? following;

  const User(
      {this.fullName,
      this.userId,
      this.userImg,
      this.email,
      this.bio,
      this.followers,
      this.following});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      fullName: snapshot["fullName"],
      userId: snapshot["userId"],
      email: snapshot["email"],
      userImg: snapshot["userImg"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "userId": userId,
        "email": email,
        "userImg": userImg,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
