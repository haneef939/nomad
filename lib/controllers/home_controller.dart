import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nomad/insta/models/post.dart';
import 'package:nomad/models/user-model.dart';
import 'package:nomad/service/navigation-service.dart';
import 'package:nomad/views/dashboard/near-by/show-near-by-users/Utils.dart';
import 'package:nomad/widgets/toast.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  //instance of firestore
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<UserModel> allUsers = RxList<UserModel>();
  RxList<Post> recentPosts = RxList<Post>();
  RxList<Marker> mapData = RxList<Marker>();
  Random random = new Random();

  RxList<UserModel> nearByUsers = RxList<UserModel>();
  RxList<UserModel> searchUsers = RxList<UserModel>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> onExitApp() async {
    return (await showDialog(
          context: NavigationService.navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  var currentIndex = 0.obs;

  distanceCalculation(Position position) async {
    // prr(position.latitude);
    // prr(position.longitude);
  }

  //show users
  allUsersList(Position position) async {
    nearByUsers.clear();
    allUsers.clear();
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('user')
        .where("userId", isNotEqualTo: auth.currentUser?.uid ?? "")
        .get();
    QuerySnapshot qShot2 = await FirebaseFirestore.instance
        .collection('posts')
        .orderBy('datePublished', descending: true)
        .get();

    recentPosts.value = qShot2.docs
        .map((doc) => Post(
              postUrl: doc['postUrl'],
            ))
        .toList();
    allUsers.value = qShot.docs
        .map((doc) => UserModel(
              userId: doc['userId'] ?? "",
              fullName: doc['fullName'] ?? "",
              country: doc['country'] ?? "",
              gender: doc['gender'] ?? "",
              dob: doc['dob'] ?? "",
              email: doc['email'] ?? "",
              lat: doc['lat'] ?? "",
              lng: doc['lng'] ?? "",
              userImg: doc.data().toString().contains('userImg')
                  ? doc['userImg']
                  : "",
              userType: doc['userType'] ?? "",
              isActive: true,
              createdBy: doc['createdBy'] ?? "",
              updatedBy: doc['updatedBy'] ?? "",
            ))
        .toList();

    prr("allUsers.length");
    prr(allUsers.length);
    for (var d in allUsers) {
      var km = getDistanceFromLatLonInKm(position.latitude, position.longitude,
          double.parse(d.lat ?? "0.0"), double.parse(d.lng ?? "0.0"));
      // var m = Geolocator.distanceBetween(position.latitude,position.longitude, d.lat,d.lng);
      // d.distance = m/1000;
      d.distance = km;
      nearByUsers.add(d);
      // prr("d.fullName");
      // prr(d.fullName);

      // print(getDistanceFromLatLonInKm(position.latitude,position.longitude, d.lat,d.lng));
    }
    nearByUsers.sort((a, b) {
      return (a.distance ?? 0.0).compareTo(b.distance ?? 0.0);
    });
    for (var d in nearByUsers) {
      mapData.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        markerId: MarkerId(random.nextInt(10).toString()),
        position:
            LatLng(double.parse(d.lat ?? "0.0"), double.parse(d.lng ?? "0.0")),
        infoWindow: InfoWindow(title: d.fullName),
      ));
    }
  }
}
