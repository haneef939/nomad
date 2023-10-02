import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  const MessageWidget(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(10.0),
            elevation: 5.0,
            color: isMe ? Color(0xffF9683A) : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
