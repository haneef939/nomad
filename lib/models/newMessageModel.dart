import 'package:flutter/material.dart';

class NewMessageModel {
  final String? image;
  final String? personName;
  final Widget? page;

  // ignore: non_constant_identifier_names
  NewMessageModel(this.page, {this.image, this.personName});
}

NewMessageModel firstModel = NewMessageModel(
  Container(),
  image: "assets/imgs/search_person.png",
  personName: "Alane Purdy",
);

List<NewMessageModel> allNewMessageSearch = [
  firstModel,
  firstModel,
  firstModel,
  firstModel,
  firstModel,
];
