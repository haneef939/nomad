import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KPrimaryButton extends StatelessWidget {
  final String btnText;
  final Icon? icon;
  final VoidCallback onPressed;

  const KPrimaryButton(
      {Key? key, required this.btnText, required this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          height: 50.h,
          width: 290.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              gradient: LinearGradient(colors: [
                Colors.white,
                Colors.white,
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
      color: Colors.red,
      fontWeight: FontWeight.bold,
    );
  }
}
