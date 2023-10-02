import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/controllers/event_controller.dart';
import 'package:nomad/controllers/home_controller.dart';
import 'package:nomad/controllers/user_controller.dart';
import 'package:nomad/insta/responsive/mobile_screen_layout.dart';
import 'package:nomad/insta/responsive/responsive_layout.dart';
import 'package:nomad/insta/responsive/web_screen_layout.dart';
import 'package:nomad/models/show-events-model.dart';
import 'package:nomad/models/nearby-model.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/dashboard/messages/chat_screen.dart';
import 'package:nomad/views/dashboard/near-by/nearBy.dart';
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

import '../../../insta/screens/user_profile.dart';
import 'dialog/dialog.dart';
//import 'package:mystery_word/views/home/recordData.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  EventController eventController = Get.put(EventController());
  HomeController homeController = Get.put(HomeController());
  AuthController authController = Get.put(AuthController());
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color colorA = Color(0xffF9683A);
    Color colorB = Color(0xff870A00);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (userController.userModel.userImg != null)
                              ? FadeInImage.assetNetwork(
                                  width: 100.w,
                                  height: 100.h,
                                  placeholder: "assets/imgs/woman-5.png",
                                  image: userController.userModel.userImg ?? "",
                                  fit: BoxFit.cover,
                                )
                              : InkWell(
                                  onTap: () => Get.to(Profile()),
                                  child: Image.asset(
                                    "assets/imgs/home/profile_img.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi",
                                style: greetingsStyle(),
                              ),
                              Text(
                                userController.userModel.fullName ?? "",
                                style: labelsStyle(),
                              ),
                              Container(),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.search,
                              color: Color(0xffBF360C), size: 30),
                          InkWell(
                              onTap: () => Get.to(const Notifications()),
                              child: const Icon(Icons.inbox,
                                  color: Color(0xffBF360C), size: 30)),
                          const Icon(Icons.notifications,
                              color: Color(0xffBF360C), size: 30),
                          Container(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(ResponsiveLayout(
                            mobileScreenLayout: MobileScreenLayout(),
                            webScreenLayout: WebScreenLayout(),
                          ));
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "1 hour left",
                                  descriptions:
                                      "\"We are going to see Madrid from above\"",
                                  text: "Yes",
                                );
                              });
                        },
                        child: Text(
                          "Nomads near you",
                          style: orangeBoldStyle(),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(NearBy());
                        },
                        child: Text(
                          "Show all in the map",
                          style: greyBoldStyle(),
                        ),
                      ),
                      Container(),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                      height: 120.h,
                      child: userController.userList.isEmpty
                          ? Center(child: Text("Loading......"))
                          : ListView.builder(
                              shrinkWrap: true, //just set this property
                              scrollDirection: Axis.horizontal,
                              itemCount: userController.userList.length,
                              itemBuilder: (_, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(UserProfile(
                                      userModel: userController.userList[index],
                                      targetUserId: userController
                                              .userList[index].userId ??
                                          "",
                                      currentUserId:
                                          userController.userModel.userId ?? "",
                                    ));
                                    // Get.to(ChatScreen(
                                    //   userModel:
                                    //       homeController.nearByUsers[index],
                                    // ));
                                    // Navigator.push(context, MaterialPageRoute(
                                    //     builder: (BuildContext context) {
                                    //   return allCategory[index].page ??
                                    //       Container();
                                    // }));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        // border: Border.all(
                                        //     color: Colors.black, width: 0.2),
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                              userController.userList[index]
                                                      .userImg ??
                                                  "",
                                              width: 60.w,
                                              height: 60.h,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (BuildContext context,
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
                                          SizedBox(height: 20.h),
                                          Text(
                                              userController.userList[index]
                                                      .fullName ??
                                                  "",
                                              style: smallSizeStyle())
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                  SizedBox(height: 20.h),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [colorA, colorB],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${eventController.totalEventDoneThisMonth}/${eventController.totalEventThisMonth}",
                                style: timeStyle(),
                              ),
                              Text(
                                "Activities\nTracked",
                                style: white20Style(),
                              ),
                              Container(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 10.h),

                                  // Text(
                                  //   "SEPTEMBER",
                                  //   style: timeMonthStyle(),
                                  // ),
                                  Text(
                                    "Activities pendientes",
                                    style: white20Style(),
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    height: 130,
                                    width: 200,
                                    child: eventController
                                            .numberOfpendingEventInThisMonth
                                            .isEmpty
                                        ? Center(
                                            child: Text(
                                            "No Pending Activities Found",
                                            textAlign: TextAlign.center,
                                            style: white15Style(),
                                          ))
                                        : GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  3, // Number of columns in the grid
                                              mainAxisSpacing:
                                                  16.0, // Spacing between rows
                                              crossAxisSpacing:
                                                  16.0, // Spacing between columns
                                            ),
                                            itemCount: eventController
                                                .numberOfpendingEventInThisMonth
                                                .length, // Number of items in the grid
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.r))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            9.0),
                                                    child: Text(
                                                      "${DateTime.fromMillisecondsSinceEpoch(eventController.numberOfpendingEventInThisMonth[index].eventDate!).day}",
                                                      style: timeMonthStyle(),
                                                    ),
                                                  ),
                                                ),
                                                //  Text('Item $index',
                                                //     style: TextStyle(
                                                //         color: Colors.white)),
                                              );
                                            },
                                          ),
                                  ),
                                  //     Row(
                                  //       children: [
                                  //         Container(
                                  //           decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                 color: Colors.white,
                                  //               ),
                                  //               borderRadius: BorderRadius.all(
                                  //                   Radius.circular(10.r))),
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Text(
                                  //               "06",
                                  //               style: timeMonthStyle(),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         SizedBox(width: 10.w),
                                  //         Container(
                                  //           decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                 color: Colors.white,
                                  //               ),
                                  //               borderRadius: BorderRadius.all(
                                  //                   Radius.circular(10.r))),
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Text(
                                  //               "06",
                                  //               style: timeMonthStyle(),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         SizedBox(width: 10.w),
                                  //         Container(
                                  //           decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                 color: Colors.white,
                                  //               ),
                                  //               borderRadius: BorderRadius.all(
                                  //                   Radius.circular(10.r))),
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Text(
                                  //               "06",
                                  //               style: timeMonthStyle(),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     SizedBox(height: 10.h),
                                  //     Row(
                                  //       children: [
                                  //         Container(
                                  //           decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                 color: Colors.white,
                                  //               ),
                                  //               borderRadius: BorderRadius.all(
                                  //                   Radius.circular(10.r))),
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Text(
                                  //               "06",
                                  //               style: timeMonthStyle(),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         SizedBox(width: 10.w),
                                  //         Container(
                                  //           decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                 color: Colors.white,
                                  //               ),
                                  //               borderRadius: BorderRadius.all(
                                  //                   Radius.circular(10.r))),
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Text(
                                  //               "06",
                                  //               style: timeMonthStyle(),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         SizedBox(width: 10.w),
                                  //         Container(
                                  //           decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                 color: Colors.white,
                                  //               ),
                                  //               borderRadius: BorderRadius.all(
                                  //                   Radius.circular(10.r))),
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Text(
                                  //               "06",
                                  //               style: timeMonthStyle(),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                ],
                              ),

                              // Icon(
                              //   Icons.arrow_forward_ios_outlined,
                              //   color: Colors.white,
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Your next events",
                        style: orangeBoldStyle(),
                      ),
                    ],
                  ),
                  (eventController.eventsDisplayList.isNotEmpty)
                      ? SizedBox(
                          height: 200,
                          child: ListView.builder(
                              shrinkWrap: true, //just set this property
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  eventController.eventsDisplayList.length,
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
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF7F8F9),
                                        // border: Border.all(
                                        //     color: Colors.black, width: 0.2),
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
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
                                                  width: 100.w,
                                                  height: 100.h,
                                                  fit: BoxFit.cover,
                                                  placeholder:
                                                      "assets/imgs/woman-5.png",
                                                  image: eventController
                                                          .eventsDisplayList[
                                                              index]
                                                          .eventCreatorImg ??
                                                      "",
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
                                                    return Image.asset(
                                                        "assets/imgs/woman-5.png");
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
                ],
              )),
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
