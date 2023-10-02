import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final snap;
  const CommentCard({Key? key, this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            // backgroundImage: NetworkImage(
            //   snap.data()['profilePic'],
            // ),
            radius: 18,
            // backgroundImage: NetworkImage(
            //   snap.data()['profilePic'],
            // ),
            child: ClipOval(
              child: Image.network(
                snap.data()['profilePic'],
                width: 60.w,
                height: 60.h,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    "assets/imgs/woman-5.png",
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: snap.data()['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        TextSpan(
                            text: ' ${snap.data()['text']}',
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        snap.data()['datePublished'].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   child: const Icon(
          //     Icons.favorite,
          //     size: 16,
          //   ),
          // )
        ],
      ),
    );
  }
}
