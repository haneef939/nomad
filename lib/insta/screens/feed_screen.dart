import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nomad/insta/utils/colors.dart';
import 'package:nomad/insta/utils/global_variable.dart';
import 'package:nomad/insta/widgets/post_card.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/views/dashboard/post-feed/create-post/createPost.dart';
import 'package:nomad/widgets/text-style/text-style.dart';

import 'add_post_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,

        //   backgroundColor: mobileBackgroundColor,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        // ),
        title: const Center(
          child: Text(
            "Feed",
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
              stream:FirebaseFirestore.instance.collection('posts').orderBy('datePublished',descending: true).snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (ctx, index) => Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: width > webScreenSize ? width * 0.3 : 0,
                      vertical: width > webScreenSize ? 15 : 0,
                    ),
                    child: PostCard(
                      snap: snapshot.data?.docs[index].data(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(CreatePost());
          Get.to(const AddPostScreen());
        },
        backgroundColor: KConstant.colorB,
        tooltip: 'Capture Picture',
        elevation: 5,
        splashColor: Colors.grey,
        child: const Icon(Icons.add, color: Colors.white, size: 29),
      ),
    );
  }
}
