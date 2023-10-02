import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nomad/controllers/auth_controller.dart';
import 'package:nomad/controllers/event_controller.dart';
import 'package:nomad/controllers/home_controller.dart';
import 'package:nomad/controllers/user_controller.dart';
import 'package:nomad/insta/providers/user_provider.dart';
import 'package:nomad/insta/screens/feed_screen.dart';
import 'package:nomad/views/dashboard/near-by/nearBy.dart';
import 'package:nomad/views/dashboard/post-feed/postFeed.dart';
import 'package:nomad/widgets/toast.dart';
import 'package:provider/provider.dart';

import 'event-manager/eventManager.dart';
import 'home/home.dart';
import 'messages/messages.dart';
//import 'package:mystery_word/views/home/recordData.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  HomeController homeController = Get.put(HomeController());
  AuthController authController = Get.put(AuthController());
  // EventController eventController = Get.put(EventController());

  @override
  void initState() {
    super.initState();
    EventController eventController = Get.put(EventController());
    authController.getNearByNomads();
    eventController.getEvents();
    addData();
  }

  getData() {}
  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  final tabs = [
    Home(),
    NearBy(),
    // PostFeed(),
    FeedScreen(),
    EventManager(),
    Messages(),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return WillPopScope(
      onWillPop: homeController.onExitApp,
      child: Scaffold(
        backgroundColor: Color(0xffF1F1F1),
        body: SafeArea(
            child: Container(child: tabs[homeController.currentIndex.value])),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red.shade500,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: BottomNavigationBar(
            currentIndex: homeController.currentIndex.value,
            type: BottomNavigationBarType.fixed,

            //  backgroundColor: Colors.black,
            selectedItemColor: Color(0xffBF360C),
            unselectedItemColor: Colors.deepOrange.withOpacity(0.6),
            iconSize: 25,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_rounded),
                  label: "location",
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined),
                  label: "Create",
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  label: "Calender",
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mark_chat_unread_rounded),
                  label: "Chat",
                  backgroundColor: Colors.blue),
            ],
            onTap: (index) {
              homeController.currentIndex.value = index;
              print(homeController.currentIndex.value);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
