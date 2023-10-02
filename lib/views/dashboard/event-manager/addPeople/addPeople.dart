import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/event_controller.dart';
import 'package:nomad/models/user-model.dart';
import 'package:nomad/widgets/text-style/text-style.dart';
import 'package:nomad/widgets/toast.dart';

class AddPeople extends StatefulWidget {
  const AddPeople({Key? key}) : super(key: key);

  @override
  _AddPeopleState createState() => _AddPeopleState();
}

class _AddPeopleState extends State<AddPeople> {
  EventController eventController = Get.put(EventController());
  var isSelected = false;
  var myColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers();
  }

  getAllUsers() async {
    eventController.showUsersList = await eventController.allUsersList();
    //   eventController.selectAuthor();

    prr("message");
    prr(eventController.showUsersList.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //new line

      appBar: AppBar(
        title: Text(
          "Add People",
        ),
        elevation: 0,
      ),
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (String searchFilter) {
                  if (searchFilter.trim().isNotEmpty) {
                    eventController.isEnableSearch.value = true;
                  } else {
                    eventController.isEnableSearch.value = false;
                  }
                  eventController.searchPeople(searchFilter: searchFilter);
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  labelText: 'Search here ...',
                ),
              ),
            ),
            (eventController.isEnableSearch.value)
                ? Expanded(child: searchList())
                : Expanded(child: userList())
          ],
        ),
      ),
    );
  }

  userList() {
    if (eventController.showUsersList.isNotEmpty) {
      return ListView.builder(
          shrinkWrap: true, //just set this property
          scrollDirection: Axis.vertical,
          itemCount: eventController.showUsersList.length,
          itemBuilder: (_, int index) {
            return GestureDetector(
              onTap: () {
                onTapList(
                    index: index,
                    userModel: eventController.showUsersList[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorEffect(
                        index: index,
                        userModel: eventController.showUsersList[index]),
                    border: Border.all(width: 0.2),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeInImage.assetNetwork(
                              width: 100.w,
                              height: 100.h,
                              placeholder: "assets/imgs/woman-5.png",
                              image: eventController
                                      .showUsersList[index].userImg ??
                                  "",
                              fit: BoxFit.cover,
                              imageErrorBuilder: (BuildContext context,
                                  Object error, StackTrace? stackTrace) {
                                return Image.asset(
                                  "assets/imgs/woman-5.png",
                                  width: 100.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                            SizedBox(width: 20.h),
                            Text(
                                eventController.showUsersList[index].fullName ??
                                    "",
                                style: black15Style()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    } else {
      return Container();
    }
  }

  searchList() {
    if (eventController.searchList != null) {
      return ListView.builder(
          shrinkWrap: true, //just set this property
          scrollDirection: Axis.vertical,
          itemCount: eventController.searchList.length,
          itemBuilder: (_, int index) {
            return GestureDetector(
              onTap: () {
                onTapList(
                    index: index, userModel: eventController.searchList[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorEffect(
                        index: index,
                        userModel: eventController.searchList[index]),
                    border: Border.all(width: 0.2),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeInImage.assetNetwork(
                              width: 100.w,
                              height: 100.h,
                              placeholder: "assets/imgs/woman-5.png",
                              image:
                                  eventController.searchList[index].userImg ??
                                      "",
                              fit: BoxFit.cover,
                              imageErrorBuilder: (BuildContext context,
                                  Object error, StackTrace? stackTrace) {
                                return Image.asset(
                                  "assets/imgs/woman-5.png",
                                  width: 100.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                            SizedBox(width: 20.h),
                            Text(
                                eventController.searchList[index].fullName ??
                                    "",
                                style: black15Style()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    } else {
      return Container();
    }
  }

  colorEffect({int? index, UserModel? userModel}) {
    if (eventController.isSelect.contains(userModel?.userId)) {
      myColor = Colors.grey.shade300;
      prr(userModel?.userId);
    } else {
      myColor = Colors.white;
    }
    return myColor;
    //  setState(() {});
  }

  onTapList({int? index, UserModel? userModel}) {
    if (eventController.isSelect.contains(userModel?.userId)) {
      eventController.selectedPeople.remove(userModel);
      eventController.isSelect.remove(userModel?.userId);
    } else {
      eventController.selectedPeople.add(userModel ?? UserModel());
      eventController.isSelect.add(userModel?.userId ?? "");
    }
    prr(eventController.selectedPeople.length);
    setState(() {});
  }
}
