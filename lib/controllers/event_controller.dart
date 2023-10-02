import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nomad/controllers/user_controller.dart';
import 'package:nomad/models/event-model.dart';
import 'package:nomad/models/show-events-model.dart';
import 'package:nomad/models/user-model.dart';
import 'package:intl/intl.dart';
import 'package:nomad/service/navigation-service.dart';
import 'package:nomad/widgets/successMessage.dart';
import 'package:nomad/widgets/toast.dart';

class EventController extends GetxController {
  //instance of firestore
  final GlobalKey<FormState> eventKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  //event maanger
  var eventName = TextEditingController().obs;
  var eventPlace = TextEditingController().obs;
  var eventLocationName;

  var eventDate = TextEditingController().obs;
  RxInt eventDate1 = 0.obs;
  var eventHour = TextEditingController().obs;
  var lat;

  var lng;

  var eventLatLng;

  var kInitialPosition = LatLng(-33.8567844, 151.213108);
  var apiKey = "AIzaSyA7bNC2gAIQZIww6oKmcl5i__UxMS66_MQ";

  //RxList<EventCreateModel> eventCreateModel = RxList<EventCreateModel>();
  // List<EventCreateModel> eventsDisplayList = [].obs;
  RxList<EventCreateModel> eventsDisplayList = RxList<EventCreateModel>();

  RxList<EventCreateModel> numberOfpendingEventInThisMonth =
      RxList<EventCreateModel>();
  RxInt totalEventThisMonth = 0.obs;
  RxInt totalEventDoneThisMonth = 0.obs;

  List<UserModel> showUsersList = [];
  List<UserModel> searchList = [];

  List<String> isSelect = [];
  List<UserModel> selectedPeople = <UserModel>[];

  var isEnableSearch = false.obs;

  List<String> acceptedUsers = [];
  List<String> pendingUsers = [];

  String? eventId;
  String? eventState;

  // RxList<UserModel> showUsersList = (List<UserModel>.of([])).obs;

  verifyField() {
    prr(lat);
    // prr(lng.value.toString());

    prr(eventName.value.text);
    prr(eventPlace.value.text);

    prr(eventDate.value.text);
    prr(eventHour.value.text);
    if (eventName.value.text.length > 3 &&
        eventPlace.value.text.length > 3 &&
        eventDate.value.text.length > 1 &&
        eventHour.value.text.length > 1) {
      return true;
    }
    return false;
  }

  registerEvent() async {
    User? user;
    UserController userController = Get.put(UserController());
    user = await auth.currentUser;
    acceptedUsers.add(auth.currentUser?.uid ?? "");
    selectedPeople.forEach((p) {
      // (auth.currentUser.uid == p.userId)
      //     ? acceptedUsers.add(p.userId)
      //     : pendingUsers.add(p.userId);
      //select all people for the event
      acceptedUsers.add(p.userId ?? "");
    });
    EventCreateModel eventCreateModel = EventCreateModel(
      eventCreator: user?.uid,
      eventCreatorName: userController.userModel.fullName,
      eventCreatorImg: userController.userModel.userImg,
      eventName: eventName.value.text,
      eventPlace: eventPlace.value.text,
      eventDate: eventDate1.value,
      eventHour: eventHour.value.text,
      acceptedUsers: acceptedUsers.toList(),
      pendingUsers: pendingUsers.toList(),
      lat: lat.toString(),
      lng: lng.toString(),
      createdBy: getTodayDate(),
      updatedBy: getTodayDate(),
    );

    try {
      DocumentReference ref =
          FirebaseFirestore.instance.collection('event').doc();
      await ref.set(eventCreateModel.setDataMap());
      eventId = ref.id;
      resetEventFields();
      getEvents();
      Get.to(const SuccessMessage(message: "Event Created Successfully"));
    } catch (e) {
      showToast('something went wrong ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson({String? userId, String? eventState}) =>
      {"eventId": eventId, "eventState": eventState};

  //states accepted, pending, rejected
  updateUserEvents({String? userId, String? eventState}) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('user').doc(userId);
    await ref
        .update({"events": toJson(userId: userId, eventState: eventState)});
  }

  resetEventFields() {
    eventName.value.clear();

    eventPlace.value.clear();
    eventDate.value.clear();
    eventHour.value.clear();
    acceptedUsers.clear();
    pendingUsers.clear();

    eventLatLng = "";
    eventLocationName = "";
  }

  String getTodayDate() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<void> fetchAndSetList() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("event").get();
    // var list = querySnapshot.docs;

    var allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    prr("Events Data");
    prr(allData);

    //  eventCreateModel.addAll(eventCreateModel);
  }

  Future<List<EventCreateModel>> getEventList() async {
    try {
      List<EventCreateModel> eventList = [];

      String currentUserUid = auth.currentUser?.uid ?? "";

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('event')
          .where('acceptedUsers', arrayContains: currentUserUid)
          .orderBy("createdBy", descending: true)
          .get();

      eventList = querySnapshot.docs
          .map((doc) => EventCreateModel(
                eventCreatorName: doc['eventCreatorName'],
                eventCreator: doc['eventCreator'],
                eventName: doc['eventName'],
                eventPlace: doc['eventPlace'],
                eventCreatorImg: doc['eventCreatorImg'],
                lat: doc['lat'],
                lng: doc['lng'],
                acceptedUsers: List.from(doc['acceptedUsers']),
                pendingUsers: List.from(doc['pendingUsers']),
                eventDate: doc['eventDate'],
                eventHour: doc['eventHour'],
                createdBy: doc['createdBy'],
                updatedBy: doc['updatedBy'],
              ))
          .toList();

      eventsDisplayList.value = eventList;

      return eventList;
    } catch (e) {
      showToast(e.toString());
      return [];
    }
  }

  // Future<List<EventCreateModel>> getEventList() async {
  //   try {
  //     List<EventCreateModel> eventList = [];

  //     FirebaseFirestore.instance
  //         .collection('event')
  //         .orderBy("createdBy", descending: true)
  //         .where('acceptedUsers', arrayContains: auth.currentUser?.uid ?? "")
  //         .snapshots()
  //         .listen((data) => eventList = data.docs
  //             .map((doc) => EventCreateModel(
  //                   eventCreatorName: doc['eventCreatorName'],
  //                   eventCreator: doc['eventCreator'],
  //                   eventName: doc['eventName'],
  //                   eventPlace: doc['eventPlace'],
  //                   eventCreatorImg: doc['eventCreatorImg'],
  //                   lat: doc['lat'],
  //                   lng: doc['lng'],
  //                   acceptedUsers: doc['acceptedUsers'].toList(),
  //                   pendingUsers: doc['pendingUsers'].toList(),
  //                   eventDate: doc['eventDate'],
  //                   eventHour: doc['eventHour'],
  //                   createdBy: doc['createdBy'],
  //                   updatedBy: doc['updatedBy'],
  //                 ))
  //             .toList());

  //     // QuerySnapshot qShot =
  //     //     await FirebaseFirestore.instance.collection('event').get();
  //     eventsDisplayList.value =
  //         eventList; // Update the value once after the loop

  //     return eventList;
  //   } catch (e) {
  //     showToast(e.toString());
  //     return [];
  //   }
  // }

  getEvents() async {
    eventsDisplayList.value = await getEventList();
    getEventHappeningThisMonth();
    getDoneEventThisMonth();
    getPenddingEventThisMonth();
    prr("message");
    prr(eventsDisplayList.length);
    //    await fetchAndSetList();
    // prr("Events Data");

    //   prr(eventCreateModel.value);
  }

  //show users
  allUsersList() async {
    resetLists();
    //
    // QuerySnapshot qShot =
    //     await FirebaseFirestore.instance.collection('user').get();
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('user')
        .where("userId", isNotEqualTo: auth.currentUser?.uid)
        .get();

    return qShot.docs
        .map((doc) => UserModel(
              userId: doc['userId'] ?? "",
              fullName: doc['fullName'] ?? "",
              country: doc['country'] ?? "",
              gender: doc['gender'] ?? "",
              dob: doc['dob'] ?? "",
              email: doc['email'] ?? "",
              userImg: doc.data().toString().contains('userImg')
                  ? doc['userImg']
                  : "",
              userType: doc['userType'] ?? "",
              isActive: true,
              createdBy: doc['createdBy'] ?? "",
              updatedBy: doc['updatedBy'] ?? "",
            ))
        .toList();
  }

  searchPeople({String? searchFilter}) {
    // populate _personList
    prr(searchFilter);
    searchList.clear();
    for (var p in showUsersList) {
      if ((p.fullName ?? "").contains(searchFilter ?? "")) {
        searchList.add(p);
      }
    }
  }

  selectAuthor() {
    UserModel? userModel;

    for (var p in showUsersList) {
      if ((p.userId ?? "").contains(auth.currentUser?.uid ?? "")) {
        selectedPeople.add(p);
        userModel = p;
      }
    }

    if (userModel != null) {
      showUsersList.remove(userModel);
    }
  }

  resetLists() {
    showUsersList.clear();
    searchList.clear();
    selectedPeople.clear();
    isSelect.clear();
    isEnableSearch.value = false;
  }

  getEventHappeningThisMonth() async {
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int currentYear = now.year;
    DateTime firstDayOfMonth = DateTime(currentYear, currentMonth, 1);
    DateTime lastDayOfMonth = DateTime(currentYear, currentMonth + 1, 0);

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('event')
        .where('eventDate',
            isGreaterThanOrEqualTo: firstDayOfMonth.millisecondsSinceEpoch)
        .where('eventDate',
            isLessThanOrEqualTo: lastDayOfMonth.millisecondsSinceEpoch)
        .get();
    totalEventThisMonth.value = snapshot.docs.length;
    print(totalEventThisMonth);
  }

  getDoneEventThisMonth() async {
    DateTime now = DateTime.now();

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('event')
        .where('eventDate', isLessThanOrEqualTo: now.millisecondsSinceEpoch)
        .get();
    totalEventDoneThisMonth.value = snapshot.docs.length;
    print(totalEventThisMonth);
  }

  getPenddingEventThisMonth() async {
    DateTime now = DateTime.now();
    List<EventCreateModel> eventList = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('event')
        .where('eventDate', isGreaterThan: now.millisecondsSinceEpoch)
        .get();

    eventList = snapshot.docs
        .map((doc) => EventCreateModel(
              eventCreatorName: doc['eventCreatorName'],
              eventCreator: doc['eventCreator'],
              eventName: doc['eventName'],
              eventPlace: doc['eventPlace'],
              eventCreatorImg: doc['eventCreatorImg'],
              lat: doc['lat'],
              lng: doc['lng'],
              acceptedUsers: List.from(doc['acceptedUsers']),
              pendingUsers: List.from(doc['pendingUsers']),
              eventDate: doc['eventDate'],
              eventHour: doc['eventHour'],
              createdBy: doc['createdBy'],
              updatedBy: doc['updatedBy'],
            ))
        .toList();
    numberOfpendingEventInThisMonth.value = eventList;
    print(totalEventThisMonth);
  }
}
