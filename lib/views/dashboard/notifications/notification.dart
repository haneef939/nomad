import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomad/insta/utils/colors.dart';
import 'package:nomad/models/noti-model.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/dashboard/notifications/search-nomad/searchNomad.dart';
import 'package:nomad/widgets/text-style/text-style.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/user_controller.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(KConstant.backOrangeButton),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () => Get.to(SearchNomad()),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search, color: KConstant.colorB, size: 30)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              "Activity",
              style: blackBoldStyle(),
            ),
            Text(
              "${userController.userModel.followers?.length ?? 0} People are following ${userController.userModel.fullName}",
              style: labelsStyle(),
            ),
            SizedBox(height: 20.h),
            Container(
                child: Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('notifications')
                      .where('targetUserId',
                          isEqualTo: userController.userModel.userId)
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data?.docs == null) {
                      return Center(
                        child: Text('No notifications.'),
                      );
                    }
                    return ListView.separated(
                        shrinkWrap: true,
                        //just set this property
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        scrollDirection: Axis.vertical,
                        itemCount: (snapshot.data?.docs ?? []).length,
                        itemBuilder: (_, int index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                          String message = doc['message'];
                          String followerId = doc['followerId'];
                          String followerImage = doc['followerImage'];
                          String followerName = doc['followerName'];
                          var notiTime = doc['timestamp'];

                          return FutureBuilder<bool>(
                              future: isFollowingBack(
                                  userController.userModel.userId ?? "",
                                  followerId),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  // Loading indicator or placeholder
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                bool isFollowingBack = snapshot.data ?? false;
                                return ListTile(
                                  leading: ClipOval(
                                    child: Image.network(
                                      followerImage,
                                      width: 60.w,
                                      height: 60.h,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                          "assets/imgs/woman-5.png",
                                          width: 60.w,
                                          height: 60.h,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          followerName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: smallSizeStyle(),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        DateFormat('yyyy-MM-dd').format(
                                            notiTime.toDate().toLocal()),
                                        style: greyLightStyle(),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          message.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: greyLightStyle(),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      GestureDetector(
                                        onTap: () {
                                          followBack(followerId);
                                        },
                                        child: isFollowingBack
                                            ? SizedBox.shrink()
                                            : Container(
                                                height: 30,
                                                width: 90,
                                                color: blueColor,
                                                child: Center(
                                                  child: Text(
                                                    "Follow Back",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                );

                                // return GestureDetector(
                                //   onTap: () {
                                //     // Navigator.push(context,
                                //     //     MaterialPageRoute(builder: (BuildContext context) {
                                //     //   return allCategory[index].page;
                                //     // }));
                                //   },
                                //   child: Container(
                                //     // decoration: BoxDecoration(
                                //     //   border: Border.all(color: Colors.black, width: 0.2),
                                //     //   borderRadius: BorderRadius.circular(20.sp),
                                //     // ),
                                //     alignment: Alignment.center,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(0.0),
                                //       child: Column(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.center,
                                //         children: [
                                //           Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.start,
                                //             children: [
                                //               Container(
                                //                 child: ClipOval(
                                //                   child: Image.network(
                                //                     followerImage,
                                //                     width: 60.w,
                                //                     height: 60.h,
                                //                     fit: BoxFit.cover,
                                //                     errorBuilder:
                                //                         (BuildContext context,
                                //                             Object error,
                                //                             StackTrace?
                                //                                 stackTrace) {
                                //                       return Image.asset(
                                //                         "assets/imgs/woman-5.png",
                                //                         width: 60.w,
                                //                         height: 60.h,
                                //                         fit: BoxFit.cover,
                                //                       );
                                //                     },
                                //                   ),
                                //                 ),
                                //               ),
                                //               SizedBox(width: 10.w),
                                //               Column(
                                //                 mainAxisAlignment:
                                //                     MainAxisAlignment.start,
                                //                 crossAxisAlignment:
                                //                     CrossAxisAlignment.start,
                                //                 children: [
                                //                   Row(
                                //                     children: [
                                //                       Text(
                                //                         followerName,
                                //                         style: smallSizeStyle(),
                                //                       ),
                                //                       SizedBox(width: 10.w),
                                //                       Text(
                                //                         notiTime.toString(),
                                //                         style: greyLightStyle(),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                   SizedBox(height: 10.h),
                                //                   Text(
                                //                     message.toString(),
                                //                     style: greyLightStyle(),
                                //                   ),
                                //                 ],
                                //               ),
                                //               Container(),
                                //             ],
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // );
                              });
                        });
                  }),
            )),
          ],
        ),
      ),
    );
  }

  Future<bool> isFollowingBack(String currentUserId, String followerId) async {
    try {
      // Replace 'users' with your Firestore collection name
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('user').doc(currentUserId);

      // Check if the current user is already following the follower
      DocumentSnapshot userDoc = await userDocRef.get();
      List<dynamic> followers = userDoc['followers'];

      return followers.contains(followerId);
    } catch (e) {
      print('Error checking if following back: $e');
      return false;
    }
  }

  Future<void> followBack(String targetUserId) async {
    try {
      // Replace 'users' with your Firestore collection name
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('user').doc(targetUserId);

      // Check if the current user is already following the follower
      DocumentSnapshot userDoc = await userDocRef.get();
      List<dynamic> followers = userDoc['followers'];

      if (!followers.contains(userController.userModel.userId)) {
        // Follow back the user
        await userDocRef.update({
          'followers': FieldValue.arrayUnion([userController.userModel.userId]),
        });

        // Notify the target user about the follow back
        await createNotification(
          targetUserId: targetUserId,
          message: '${userController.userModel.fullName} followed you back.',
          followerId: userController.userModel.userId,
          name: userController.userModel.fullName ?? "",
          followerImage:
              'current_user_image_url', // Replace with the current user's image URL
        );
      }
    } catch (e) {
      print('Error following back: $e');
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
}
