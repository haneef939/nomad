import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/user_controller.dart';
import 'package:nomad/insta/providers/user_provider.dart';
import 'package:nomad/service/navigation-service.dart';
import 'package:nomad/utils/routes.dart';
import 'package:nomad/utils/theme.dart';
import 'package:nomad/views/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _requestLocationPermission();
  Get.put(UserController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

Future<void> _requestLocationPermission() async {
  final permissionStatus = await Permission.location.request();
  if (permissionStatus.isDenied) {
    // Handle denied permission
    print('Location permission is denied.');
  } else if (permissionStatus.isGranted) {
    // Permission granted, proceed as needed
    print('Location permission is granted.');
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    return ScreenUtilInit(
      designSize: Size(375, 825),
      builder: (_, __) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => UserProvider(),
            ),
          ],
          child: GetMaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            title: "Nomad Club",
            debugShowCheckedModeBanner: false,
            home: Splash(),
            builder: (BuildContext context, Widget? child) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: Builder(
                  builder: (BuildContext context) {
                    return MediaQuery(
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                      child: child ?? Container(),
                    );
                  },
                ),
              );
            },
            color: Colors.white,
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: "/splash",
            theme: CustomTheme.getThemeData(),
          ),
        );
      },
    );
  }
}
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ChatScreen(),
//     );
//   }
// }

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   User? _user;
//   String _messageText = '';

//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }

//   void getCurrentUser() async {
//     // try {
//     //   final user = await _auth.currentUser();
//     //   if (user != null) {
//     //     _user = user;
//     //   }
//     // } catch (e) {
//     //   print(e);
//     // }
//   }
//   String generateRandomAlphaNumeric(int length) {
//     const charset =
//         'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
//     Random random = Random();
//     return String.fromCharCodes(Iterable.generate(
//         length, (_) => charset.codeUnitAt(random.nextInt(charset.length))));
//   }

//   void sendMessage() async {
//     if (_messageText.isNotEmpty) {
//       _firestore.collection('chat_rooms').doc("NtTc364ND6ZqX6Au0cQo1").set({
//         'participants': ["A", "C"],
//       }).whenComplete(() {
//         // Create a message in the subcollection
//         _firestore
//             .collection('chat_rooms')
//             .doc("NtTc364ND6ZqX6Au0cQo1")
//             .collection('messages')
//             .add({
//           'text': '$_messageText',
//           'sender': "A",
//           'timestamp': FieldValue.serverTimestamp(),
//         }).whenComplete(() {
//           _messageText = "";
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat App'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () async {
//               await _auth.signOut();
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: StreamBuilder(
//               stream: _firestore.collection('chat_rooms').where('participants',
//                       arrayContainsAny: ["A", "B"]) // Filter by participants
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 final chatRooms = snapshot.data?.docs ??
//                     []; // Assuming you want to display messages from the first chat room in the list
//                 final chatRoom = chatRooms[1];
//                 final chatRoomId = chatRoom.id;
//                 return StreamBuilder(
//                     stream: _firestore
//                         .collection('chat_rooms')
//                         .doc(chatRoomId)
//                         .collection('messages')
//                         .orderBy('timestamp')
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       List<Widget> messageWidgets = [];
//                       final messages = (snapshot.data?.docs ?? []).reversed;

//                       for (var message in messages) {
//                         final messageText = message['text'];
//                         final messageSender = message['sender'];

//                         final messageWidget = MessageWidget(
//                           sender: messageSender,
//                           text: messageText,
//                           isMe: "A" == messageSender,
//                         );

//                         messageWidgets.add(messageWidget);
//                       }
//                       return ListView(
//                         reverse: true,
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 10.0, vertical: 20.0),
//                         children: messageWidgets,
//                       );
//                     });
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     onChanged: (value) {
//                       _messageText = value;
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Enter your message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MessageWidget extends StatelessWidget {
//   final String sender;
//   final String text;
//   final bool isMe;

//   const MessageWidget(
//       {super.key,
//       required this.sender,
//       required this.text,
//       required this.isMe});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment:
//             isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             sender,
//             style: TextStyle(
//               fontSize: 12.0,
//               color: Colors.grey,
//             ),
//           ),
//           Material(
//             borderRadius: BorderRadius.circular(10.0),
//             elevation: 5.0,
//             color: isMe ? Colors.lightBlueAccent : Colors.white,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   fontSize: 15.0,
//                   color: isMe ? Colors.white : Colors.black,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
