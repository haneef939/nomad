import 'package:flutter/material.dart';

class NotiModel {
  final String? image;
  final String? personName;
  final String? title;
  final String? time;
  final Widget? page;

  // ignore: non_constant_identifier_names
  NotiModel(this.page, {this.image, this.personName, this.title, this.time});
}

NotiModel firstModel = NotiModel(Container(),
    image: "assets/imgs/notification_person.png",
    title: "Sent an invite",
    personName: "Lola",
    time: "3 hours ago");

List<NotiModel> allNoti = [
  firstModel,
  firstModel,
  firstModel,
  firstModel,
  firstModel,
];
