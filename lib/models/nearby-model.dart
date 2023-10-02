import 'package:flutter/material.dart';

class NearByModel {
  final String? image;
  final String? title;
  final Widget? page;

  // ignore: non_constant_identifier_names
  NearByModel(this.page, {this.image, this.title});
}

NearByModel firstModel = NearByModel(Container(),
    image: "assets/imgs/home/sung-wang-209324-unsplash.png", title: "Lola");
NearByModel secondModel = NearByModel(Container(),
    image: "assets/imgs/home/sung-wang-209324-unsplash.png", title: "Lola");
NearByModel thirdModel = NearByModel(Container(),
    image: "assets/imgs/home/sung-wang-209324-unsplash.png", title: "Lola");

List<NearByModel> allCategory = [
  firstModel,
  secondModel,
  thirdModel,
  thirdModel,
  thirdModel,
  thirdModel,
  thirdModel
];
