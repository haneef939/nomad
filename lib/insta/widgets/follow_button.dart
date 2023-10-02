import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()?  function;
  final Color? backgroundColor;
  final Color? borderColor;
  final String? text;
  final Color? textColor;
  const FollowButton({
    Key?  key,
     this.backgroundColor,
     this.borderColor,
     this.text,
     this.textColor,
    this.function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: 250,
          height: 27,
          child: Text(
            text ?? "",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
