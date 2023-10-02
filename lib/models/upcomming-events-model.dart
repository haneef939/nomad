import 'package:flutter/material.dart';

class NextEventsModel {
  final String? image;
  final String? eventName;
  final String? date;
  final String? hour;
  final String? personName;
  final String? location;
  final Widget? page;

  // ignore: non_constant_identifier_names
  NextEventsModel(
    this.page, {
    this.image,
    this.eventName,
    this.personName,
    this.date,
    this.hour,
    this.location,
  });
}

NextEventsModel firstModel = NextEventsModel(Container(),
    image: "assets/imgs/woman-5.png",
    date: "02/12/2022",
    hour: "08",
    location: "Location",
    eventName: "Event Name",
    personName: "Jhon");

List<NextEventsModel> allNextEvents = [
  firstModel,
  firstModel,
  firstModel,
];
