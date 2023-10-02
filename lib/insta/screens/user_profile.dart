import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/user-model.dart';
import '../../views/dashboard/messages/chat_screen.dart';

class UserProfile extends StatefulWidget {
  final String currentUserId;
  final String targetUserId;
  final UserModel userModel;

  UserProfile(
      {required this.currentUserId,
      required this.userModel,
      required this.targetUserId});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isFollowing = false;
  bool isMessageEnabled = false;

  @override
  void initState() {
    super.initState();
    checkFollowingStatus();
  }

  void checkFollowingStatus() async {
    try {
      // Replace 'users' with your Firestore collection name
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.targetUserId)
          .get();

      if (userDoc.exists) {
        List<dynamic> followers = userDoc['followers'];
        isFollowing = followers.contains(widget.currentUserId);
        isMessageEnabled = isFollowing;
      }
    } catch (e) {
      print('Error checking following status: $e');
    }

    setState(() {});
  }

  void toggleFollow() async {
    try {
      // Replace 'users' with your Firestore collection name
      DocumentReference userDocRef = FirebaseFirestore.instance
          .collection('user')
          .doc(widget.targetUserId);

      if (isFollowing) {
        // If already following, unfollow
        await userDocRef.update({
          'followers': FieldValue.arrayRemove([widget.currentUserId]),
        });
        // Notify the target user about

        // Notify the target user about following
        await createNotification(
          targetUserId: widget.targetUserId,
          message: '${widget.userModel.fullName ?? ""} unfollowed you.',
          followerId: widget.currentUserId,
          name: widget.userModel.fullName ?? "",
          followerImage: widget
              .userModel.userImg, // Replace with the current user's image URL
        );
      } else {
        // If not following, follow
        await userDocRef.update({
          'followers': FieldValue.arrayUnion([widget.currentUserId]),
        });

        // Notify the target user about following
        await createNotification(
          targetUserId: widget.targetUserId,
          message: '${widget.userModel.fullName ?? ""} started following you.',
          followerId: widget.currentUserId,
          name: widget.userModel.fullName ?? "",
          followerImage: widget
              .userModel.userImg, // Replace with the current user's image URL
        );
      }

      checkFollowingStatus();
    } catch (e) {
      print('Error toggling follow: $e');
    }
  }

  Future<void> createNotification({
    required String targetUserId,
    required String message,
    required String name,
    String? followerId,
    String? followerImage,
  }) async {
    try {
      // Create a notification in Firestore
      await FirebaseFirestore.instance.collection('notifications').add({
        'targetUserId': targetUserId,
        'followerId': followerId ?? '',
        'followerImage':
            followerImage ?? '', // Include the current user's image URL
        'message': message,
        "followerName": name,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error creating notification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              // radius: 60,
              // Replace with your user's profile picture
              // backgroundImage: AssetImage('assets/profile_picture.jpg'),
              child: Image.network(
                widget.userModel.userImg ?? "",
                width: 90.w,
                height: 90.h,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    "assets/imgs/woman-5.png",
                    width: 90.w,
                    height: 90.h,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.userModel.fullName ?? "",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${widget.userModel.email ?? ""}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    toggleFollow();
                  },
                  child: Text(isFollowing ? 'Following' : 'Follow'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: isMessageEnabled
                      ? () {
                          // Handle message button click
                          Get.to(ChatScreen(
                            userModel: widget.userModel,
                          ));
                        }
                      : null,
                  child: Text('Message'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
