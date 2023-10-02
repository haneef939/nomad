import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/models/show-events-model.dart';
import 'package:nomad/models/message-model.dart';
import 'package:nomad/models/nearby-model.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/dashboard/messages/search-messages/searchMessages.dart';
import 'package:nomad/views/dashboard/notifications/notification.dart';
import 'package:nomad/views/initial-screens/add-profile-pic/profilePic.dart';
import 'package:nomad/views/initial-screens/login/login.dart';
import 'package:nomad/views/initial-screens/otp-screen/otpSecreen.dart';
import 'package:nomad/views/initial-screens/scan-passport/fill-in-data/fillData.dart';
import 'package:nomad/views/initial-screens/scan-passport/scanPassport.dart';
import 'package:nomad/views/initial-screens/terms-of-service/termsOfService.dart';
import 'package:nomad/views/payment-section/subscription/activaSubscription.dart';
import 'package:nomad/views/payment-section/success/paymentSuccess.dart';
import 'package:nomad/views/profile/profile.dart';
import 'package:nomad/widgets/text-style/text-style.dart';

import '../../../controllers/event_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/user_controller.dart';
import '../dashboard.dart';
import 'chat_screen.dart';
import 'create_group.dart';
import 'dialog/dialog.dart';
//import 'package:mystery_word/views/home/recordData.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  void initState() {
    super.initState();
  }

  EventController eventController = Get.put(EventController());
  HomeController homeController = Get.put(HomeController());
  UserController userController = Get.put(UserController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color colorA = Color(0xffF9683A);
    Color colorB = Color(0xff870A00);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Messages",
                    style: greyBoldStyle(),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Get.to(SearchMessages()),
                        child: const Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(CreateGroupScreen());
                        },
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              (eventController.eventsDisplayList.isNotEmpty)
                  ? SizedBox(
                      height: 190.h,
                      child: ListView.builder(
                          shrinkWrap: true, //just set this property
                          scrollDirection: Axis.horizontal,
                          itemCount: eventController.eventsDisplayList.length,
                          itemBuilder: (_, int index) {
                            return GestureDetector(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //   return allCategory[index].page ??
                                //       Container();
                                // }));
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF7F8F9),
                                    // border: Border.all(
                                    //     color: Colors.black, width: 0.2),
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: ClipOval(
                                            child: FadeInImage.assetNetwork(
                                              width: 90.w,
                                              height: 90.h,
                                              fit: BoxFit.contain,
                                              placeholder:
                                                  "assets/imgs/woman-5.png",
                                              image: eventController
                                                      .eventsDisplayList[index]
                                                      .eventCreatorImg ??
                                                  "",
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  "assets/imgs/woman-5.png",
                                                  width: 90.w,
                                                  height: 90.h,
                                                  fit: BoxFit.contain,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          eventController
                                                  .eventsDisplayList[index]
                                                  .eventName ??
                                              "",
                                          style: smallSizeStyle(),
                                        ),
                                        Text(
                                          "${eventController.eventsDisplayList[index].acceptedUsers?.length} people",
                                          style: greyLightStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }))
                  : const Center(
                      child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Your next events will show up here"),
                    )),
              // Container(
              //     height: 180.h,
              //     child: ListView.builder(
              //         shrinkWrap: true, //just set this property
              //         scrollDirection: Axis.horizontal,
              //         itemCount: allEvents.length,
              //         itemBuilder: (_, int index) {
              //           return GestureDetector(
              //             onTap: () {
              //               // Navigator.push(context,
              //               //     MaterialPageRoute(builder: (BuildContext context) {
              //               //   return allCategory[index].page;
              //               // }));
              //             },
              //             child: Padding(
              //               padding: EdgeInsets.only(left: 10.w, right: 10.w),
              //               child: Container(
              //                 color: Color(0xffF7F8F9),
              //                 // decoration: BoxDecoration(
              //                 //   border: Border.all(color: Colors.black, width: 0.2),
              //                 //   borderRadius: BorderRadius.circular(20.sp),
              //                 // ),
              //                 alignment: Alignment.center,
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(18.0),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       Container(
              //                           child: ClipOval(
              //                               child: Image.asset(
              //                                   allEvents[index].location ??
              //                                       ""))),
              //                       SizedBox(height: 20.h),
              //                       Text(
              //                         allEvents[index].eventName ?? "",
              //                         style: smallSizeStyle(),
              //                       ),
              //                       Text(
              //                         "${allEvents[index].eventName} people",
              //                         style: greyLightStyle(),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           );
              //         })),
              SizedBox(height: 20.h),
              Container(
                height: 700.h,
                color: Color(0xffF7F8F9),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recent",
                        style: blackBoldSmallStyle(),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: StreamBuilder(
                            stream: _firestore
                                .collection('chat_rooms')
                                .where('participants', arrayContainsAny: [
                              userController.userModel.userId,
                              "B"
                            ]) // Filter by participants
                                .snapshots(),
                            builder: (context, snapshot) {
                              return snapshot.data?.docs.isEmpty == true
                                  ? Center(
                                      child: Text(
                                        "Chat List is empty",
                                        style: smallSizeStyle(),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      //just set this property
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data?.docs.length,
                                      itemBuilder: (_, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(ChatScreen(
                                              docId:
                                                  snapshot.data?.docs[index].id,
                                              snapshot: snapshot
                                                  .data?.docs[index]
                                                  .data(),
                                            ));
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(builder: (BuildContext context) {
                                            //   return allCategory[index].page;
                                            // }));
                                          },
                                          child: Container(
                                            // decoration: BoxDecoration(
                                            //   border: Border.all(color: Colors.black, width: 0.2),
                                            //   borderRadius: BorderRadius.circular(20.sp),
                                            // ),
                                            //     alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Container(
                                                      //     child: Image.asset(
                                                      //         allMessages[index]
                                                      //                 .image ??
                                                      //             "")),
                                                      ClipOval(
                                                        child: Image.network(
                                                          snapshot.data?.docs[
                                                                      index]
                                                                  ["userImg"] ??
                                                              "",
                                                          width: 60.w,
                                                          height: 60.h,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Object error,
                                                                  StackTrace?
                                                                      stackTrace) {
                                                            return Image.asset(
                                                              "assets/imgs/woman-5.png",
                                                              width: 60.w,
                                                              height: 60.h,
                                                              fit: BoxFit.cover,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.w),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                snapshot.data?.docs[
                                                                            index]
                                                                        [
                                                                        "recieverName"] ??
                                                                    "N/A",
                                                                style:
                                                                    smallSizeStyle(),
                                                              ),
                                                              SizedBox(
                                                                  width: 10.w),
                                                              Text(
                                                                "Time",
                                                                style:
                                                                    greyLightStyle(),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          SizedBox(height: 5.h),
                                                          Text(
                                                            "Message",
                                                            style:
                                                                greyBoldStyle(),
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                            }),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  viewFilter({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => viewFilterDialog(context));
  }

  Dialog viewFilterDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 200.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          border: Border.all(
                            color: Colors.deepOrangeAccent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.white,
                        ),
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1 hour left",
                      style: greetingsStyle(),
                    ),
                    Text(
                      "\"We are going to see Madrid from above\"",
                      overflow: TextOverflow.ellipsis,
                      style: labelsStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
