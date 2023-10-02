import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nomad/models/user-model.dart';

import '../../../controllers/user_controller.dart';
import '../../../widgets/buttons/create_group_button.dart';
import '../../../widgets/buttons/home_button.dart';
import 'chat_screen.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  UserController userController = Get.put(UserController());
  final List<UserModel> selectedUsers = [];
  final List<UserModel> searchResults = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Set<String> addedUserIds =
      Set(); // Store added user IDs to prevent duplicates

  final TextEditingController _searchController = TextEditingController();

  // Simulated user search function, you should replace this with actual search logic
  List<UserModel> searchUsers(String query) {
    // Simulated user data

    // Filter users based on the query and exclude already added users
    return userController.userList.where((user) {
      final isNotAdded = !addedUserIds.contains(user.userId);
      return isNotAdded &&
          (user.fullName ?? "").toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void _addToSelectedUsers(UserModel user) {
    setState(() {
      selectedUsers.insert(0, user); // Add to the beginning of the list
      addedUserIds.add(user.userId ?? ""); // Mark as added
    });
  }

  @override
  void initState() {
    super.initState();
    searchResults.addAll(userController.userList ?? []);
    addedUserIds.add(userController.userModel.userId ?? "");
  }

  void _removeFromSelectedUsers(UserModel user) {
    setState(() {
      selectedUsers.remove(user);
      addedUserIds.remove(user.userId); // Remove from the added list
    });
  }

  String generateRandomAlphaNumeric(int length) {
    const charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => charset.codeUnitAt(random.nextInt(charset.length))));
  }

  void sendMessage() async {
    if (_searchController.text.isNotEmpty) {
      _firestore.collection('chat_rooms').add({
        'participants': addedUserIds,
        'senderId': userController.userModel.userId,
        'senderName': userController.userModel.fullName,
        'recieverId': "",
        'recieverName': _searchController.text.trim() ?? "",
        "userImg": "",
      }).then((value) {
        value.get().then((value1) {
          Get.to(ChatScreen(
            snapshot: value1.data(),
            docId: value1.id,
          ));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Search and Selection'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      // Call the search function here and update the search results
                      // setState(() {
                      //   searchResults.clear(); // Clear previous search results
                      //   if (query.isNotEmpty) {
                      //     searchResults.addAll(searchUsers(query));
                      //   } else {
                      //     searchResults.addAll(userController.userList ?? []);
                      //   }
                      // });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Group Name',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    if (_searchController.text.isNotEmpty &&
                        addedUserIds.length > 0) {
                      sendMessage();
                    }
                  },
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
                          child: Text("Create Group",
                              style: TextStyle(
                                fontFamily: "WorkSan",
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ),
                ),
                // CreateGroupButton(
                //   btnText: "Create Group",
                //   onPressed: () {

                //   },
                // ),
              ],
            ),
          ),
          Container(
            height: 100, // Adjust the height as needed
            child: selectedUsers.isEmpty
                ? Center(child: const Text("Select Users to create group"))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedUsers.length,
                    itemBuilder: (context, index) {
                      final user = selectedUsers[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      user.userImg ?? "",
                                      width: 30.w,
                                      height: 30.h,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                          "assets/imgs/woman-5.png",
                                          width: 30.w,
                                          height: 30.h,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  Text(user.fullName ?? ""),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                child: Icon(
                                  Icons.cancel,
                                  size: 20,
                                  color: Color(0xffF9683A),
                                ),
                                onTap: () {
                                  _removeFromSelectedUsers(user);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Expanded(
            child: searchResults.isEmpty
                ? const Center(
                    child: Text("Loading...."),
                  )
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final user = searchResults[index];
                      return ListTile(
                        leading: ClipOval(
                          child: Image.network(
                            user.userImg ?? "",
                            width: 40.w,
                            height: 40.h,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Image.asset(
                                "assets/imgs/woman-5.png",
                                width: 40.w,
                                height: 40.h,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        title: Text(user.fullName ?? ""),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Color(0xffF9683A),
                          ),
                          onPressed: () {
                            _addToSelectedUsers(user);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
