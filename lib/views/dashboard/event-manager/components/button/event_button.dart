import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventButton extends StatelessWidget {
  final String btnText;
  final Icon? icon;
  final Function onPressed;

  const EventButton(
      {Key? key, required this.btnText, required this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onPressed,
      child: Center(
        child: Container(
          height: 50.h,
          width: 290.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              gradient: LinearGradient(colors: [
                Color(0xffF9683A),
                Color(0xffF9683A),
              ])),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) icon ?? const Icon(Icons.place),
              if (icon != null)
                SizedBox(
                  width: 10.w,
                ),
              Text(btnText, style: kAuthStyle())
            ],
          )),
        ),
      ),
    );
  }

  TextStyle kAuthStyle() {
    return TextStyle(
      fontFamily: "WorkSan",
      fontSize: 18.sp,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}
