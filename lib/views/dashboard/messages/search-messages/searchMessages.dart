import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/models/newMessageModel.dart';
import 'package:nomad/models/noti-model.dart';
import 'package:nomad/models/search-model.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/dashboard/messages/chat_screen.dart';
import 'package:nomad/widgets/text-fields/searchField.dart';
import 'package:nomad/widgets/text-style/text-style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/user_controller.dart';
import '../../../../insta/screens/user_profile.dart';
import '../../../../models/user-model.dart';
import 'components/searchPeople.dart';

class SearchMessages extends StatefulWidget {
  const SearchMessages({Key? key}) : super(key: key);

  @override
  _SearchMessagesState createState() => _SearchMessagesState();
}

class _SearchMessagesState extends State<SearchMessages> {
  AuthController appController = Get.put(AuthController());
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    userController.localList.addAll(userController.userList);
    super.initState();
  }

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
          "New Messages",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchPeople(appController: appController),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                  child: Expanded(
                child: userController.localList.isEmpty
                    ? Center(child: Text("Loading...."))
                    : ListView.separated(
                        shrinkWrap: true,
                        //just set this property
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        scrollDirection: Axis.vertical,
                        itemCount: userController.localList.length,
                        itemBuilder: (_, int index) {
                          return GestureDetector(
                            onTap: () {
                              // Get.to(ChatScreen(
                              //   userModel: userController.localList[index],
                              // ));
                              Get.to(UserProfile(
                                userModel: userController.localList[index],
                                targetUserId:
                                    userController.localList[index].userId ??
                                        "",
                                currentUserId:
                                    userController.userModel.userId ?? "",
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
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            userController
                                                    .localList[index].userImg ??
                                                "",
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
                                        // Container(
                                        //     child: Image.asset(userController
                                        //             .userList[index].userImg ??
                                        //         "")),
                                        SizedBox(width: 10.w),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  userController
                                                          .localList[index]
                                                          .fullName ??
                                                      "",
                                                  style: smallSizeStyle(),
                                                ),
                                                SizedBox(width: 10.w),
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                          ],
                                        ),
                                        Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
