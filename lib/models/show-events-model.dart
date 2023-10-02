import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowEventModel {
  String? location;
  String? eventName;
  String? eventPlace;
  String? eventDate;
  String? eventCreator;
  String? eventLatLng;
  Widget? eventHour;

  // ignore: non_constant_identifier_names
  ShowEventModel({
    this.location,
    this.eventName,
    this.eventPlace,
    this.eventDate,
    this.eventHour,
    this.eventCreator,
    this.eventLatLng,
  });

  fromSnapShots(DocumentSnapshot snapshot) {
    return {
      "location": location,
      "eventName": eventName,
      "eventDate": eventDate,
      "eventPlace": eventPlace,
      "eventCreator": eventCreator,
      "eventLatLng": eventLatLng,
    };
  }
}

ShowEventModel firstModel = ShowEventModel(
    eventHour: Container(),
    location: "assets/imgs/home/Group 1260.png",
    eventName: "Lola",
    eventDate: "3");

List<ShowEventModel> allEvents = [
  firstModel,
  firstModel,
  firstModel,
  firstModel,
];
