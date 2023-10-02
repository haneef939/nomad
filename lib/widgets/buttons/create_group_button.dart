import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateGroupButton extends StatelessWidget {
  final String btnText;
  final Icon? icon;
  final VoidCallback onPressed;

  const CreateGroupButton(
      {Key? key, required this.btnText, required this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: () => onPressed,
      child: Center(
        child: Container(
          height: 40.h,
          width: 120.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              gradient: const LinearGradient(colors: [
                Color(0xffF9683A),
                Color(0xff8A0301),
              ])),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) icon ?? Icon(Icons.place),
              if (icon != null)
                SizedBox(
                  width: 10.w,
                ),
              Text(btnText, style: kAuthStyle1())
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

  TextStyle kAuthStyle1() {
    return TextStyle(
      fontFamily: "WorkSan",
      fontSize: 14.sp,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}
