import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nomad/insta/screens/add_post_screen.dart';
import 'package:nomad/insta/screens/feed_screen.dart';
import 'package:nomad/insta/screens/profile_screen.dart';
import 'package:nomad/insta/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser?.uid,
  ),
];
