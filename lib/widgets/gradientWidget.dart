import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget gradientContainer(
    {required BuildContext context, required Color colorA, required Color colorB, required Widget widget}) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [colorA, colorB],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
    ),
    child: widget,
  );
}
