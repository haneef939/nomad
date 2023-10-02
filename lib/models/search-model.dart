import 'package:flutter/material.dart';

class SearchModel {
  final String? image;
  final String? personName;
  final Widget? page;

  // ignore: non_constant_identifier_names
  SearchModel(this.page, {this.image, this.personName});
}

SearchModel firstModel = SearchModel(
  Container(),
  image: "assets/imgs/search_person.png",
  personName: "Alane Purdy",
);

List<SearchModel> allRecentSearch = [
  firstModel,
  firstModel,
  firstModel,
  firstModel,
  firstModel,
];
