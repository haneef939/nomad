import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:nomad/controllers/home_controller.dart';
import 'package:nomad/insta/screens/profile_screen.dart';
import 'package:nomad/insta/utils/colors.dart';
import 'package:nomad/insta/utils/global_variable.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = true;
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration:
                const InputDecoration(labelText: 'Search for a user...'),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
              print(_);
            },
          ),
        ),
      ),
      body: isShowUsers
          ? ListView.builder(
              itemCount: homeController.allUsers.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        uid: homeController.allUsers[index].userId,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        homeController.allUsers[index].userImg ?? "",
                      ),
                      radius: 16,
                    ),
                    title: Text(
                      homeController.allUsers[index].fullName ?? "",
                    ),
                  ),
                );
              },
            )
          :Container(),
          // StaggeredGridView.countBuilder(
          //     crossAxisCount: 3,
          //     itemCount: homeController.recentPosts.length,
          //     itemBuilder: (context, index) => Image.network(
          //       homeController.recentPosts[index].postUrl ?? "",
          //       fit: BoxFit.cover,
          //     ),
          //     staggeredTileBuilder: (index) =>
          //         MediaQuery.of(context).size.width > webScreenSize
          //             ? StaggeredTile.count(
          //                 (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
          //             : StaggeredTile.count(
          //                 (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
          //     mainAxisSpacing: 8.0,
          //     crossAxisSpacing: 8.0,
          //   ),
      // FutureBuilder(
      //           future: FirebaseFirestore.instance
      //               .collection('posts')
      //               .orderBy('datePublished')
      //               .get(),
      //           builder: (context, snapshot) {
      //             if (snapshot.hasData) {
      //               return const Center(
      //                 child: CircularProgressIndicator(),
      //               );
      //             }
      //
      //           },
      //         ),
    );
  }
}
