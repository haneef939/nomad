import 'package:flutter/material.dart';

class MessageModel {
  final String? image;
  final String? personName;
  final String? message;
  final String? time;
  final Widget? page;

  // ignore: non_constant_identifier_names
  MessageModel(this.page,
      {this.image, this.personName, this.time, this.message});
}

MessageModel firstModel = MessageModel(Container(),
    image: "assets/imgs/search_person.png",
    personName: "Alane Purdy",
    time: '2 hours ago',
    message: 'Lets schedule a call');

List<MessageModel> allMessages = [
  firstModel,
  firstModel,
  firstModel,
  firstModel,
  firstModel,
];
