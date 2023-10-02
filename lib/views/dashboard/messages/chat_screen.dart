import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/user_controller.dart';
import '../../../models/user-model.dart';
import '../../../widgets/buttons/message_widget.dart';

class ChatScreen extends StatefulWidget {
  Map<String, dynamic>? snapshot;
  String? docId;
  UserModel? userModel;
  ChatScreen({super.key, this.userModel, this.snapshot, this.docId});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController messgaeCOntroller = TextEditingController();
  UserController userController = Get.put(UserController());
  String _messageText = '';
  var docId;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    // try {
    //   final user = await _auth.currentUser();
    //   if (user != null) {
    //     _user = user;
    //   }
    // } catch (e) {
    //   print(e);
    // }

    docId = widget.docId ?? generateRandomAlphaNumeric(15);
  }

  String generateRandomAlphaNumeric(int length) {
    const charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => charset.codeUnitAt(random.nextInt(charset.length))));
  }

  void sendMessage() async {
    if (_messageText.isNotEmpty) {
      _firestore.collection('chat_rooms').doc(docId).set({
        'participants': widget.snapshot?["participants"] ??
            [userController.userModel.userId, widget.userModel?.userId ?? ""],
        'senderId':
            widget.snapshot?["senderId"] ?? userController.userModel.userId,
        'senderName':
            widget.snapshot?["senderName"] ?? userController.userModel.fullName,
        'recieverId':
            widget.snapshot?["recieverId"] ?? widget.userModel?.userId ?? "",
        'recieverName': widget.snapshot?["recieverName"] ??
            widget.userModel?.fullName ??
            "",
        "userImg":
            widget.snapshot?["userImg"] ?? widget.userModel?.userImg ?? "",
      }).whenComplete(() {
        // Create a message in the subcollection
        _firestore
            .collection('chat_rooms')
            .doc(docId)
            .collection('messages')
            .add({
          'text': '$_messageText',
          'senderId': widget.snapshot?["senderId"] ??
              userController.userModel.userId ??
              "",
          'senderName': widget.snapshot?["senderName"] ??
              userController.userModel.fullName ??
              "",
          'recieverId':
              widget.snapshot?["recieverId"] ?? widget.userModel?.userId ?? "",
          'recieverName': widget.snapshot?["recieverName"] ??
              widget.userModel?.fullName ??
              "",
          'timestamp': FieldValue.serverTimestamp(),
        }).whenComplete(() {
          _messageText = "";
          messgaeCOntroller.clear();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.snapshot?["recieverName"] ?? 'Chat Room'),
        // leading: SizedBox.shrink(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder(
                  stream: _firestore
                      .collection('chat_rooms')
                      .doc(widget.docId ?? docId)
                      .collection('messages')
                      .orderBy('timestamp')
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<Widget> messageWidgets = [];
                    final messages = (snapshot.data?.docs ?? []).reversed;
                    for (var message in messages) {
                      final messageText = message['text'];
                      final messageSender = message['senderId'];
                      final messageSenderName = message['senderName'];
                      final messageWidget = MessageWidget(
                        sender: messageSenderName,
                        text: messageText,
                        isMe: userController.userModel.userId == messageSender,
                      );

                      messageWidgets.add(messageWidget);
                    }
                    if (snapshot.data?.docs.isEmpty == true) {
                      return Center(child: Text("Start Chat"));
                    }
                    return ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: messageWidgets,
                    );
                  })),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messgaeCOntroller,
                    onChanged: (value) {
                      _messageText = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Color(0xffF9683A),
                  ),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
