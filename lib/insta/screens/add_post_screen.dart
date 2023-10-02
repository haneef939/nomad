import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nomad/insta/providers/user_provider.dart';
import 'package:nomad/insta/resources/firestore_methods.dart';
import 'package:nomad/insta/utils/colors.dart';
import 'package:nomad/insta/utils/utils.dart';
import 'package:nomad/utils/constant.dart';
import 'package:nomad/widgets/buttons/home_button.dart';
import 'package:nomad/widgets/buttons/primary_button.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file ?? Uint8List(0),
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    if (_file == null) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 95, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              child: const Text(
                "Upload feed",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              // btnText: "Upload feed",
              // icon: KConstant.upload_pic,
              onPressed: () {
                _selectImage(context);
                //    Get.to(ActiveSubs());
              }),

          // IconButton(
          //   icon: const Icon(
          //     Icons.upload,
          //   ),
          //   onPressed: () => _selectImage(context),
          // ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          //   backgroundColor: mobileBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: clearImage,
          ),
          title: const Text(
            'Post to',
          ),
          centerTitle: false,
          actions: <Widget>[
            TextButton(
              onPressed: () => postImage(
                userProvider.getUser?.userId ?? "",
                userProvider.getUser?.fullName ?? "",
                userProvider.getUser?.userImg ?? "",
              ),
              child: const Text(
                "Post",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            )
          ],
        ),
        // POST FORM
        body: Column(
          children: <Widget>[
            isLoading
                ? const LinearProgressIndicator()
                : const Padding(padding: EdgeInsets.only(top: 0.0)),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  // backgroundImage: NetworkImage(
                  //   userProvider.getUser?.userImg ?? "",
                  // ),
                  child: ClipOval(
                    child: Image.network(
                      userProvider.getUser?.userImg ?? "",
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        hintText: "Write a caption...",
                        border: InputBorder.none),
                    maxLines: 8,
                  ),
                ),
                SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                        image: MemoryImage(_file ?? Uint8List(2)),
                      )),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      );
    }
  }
}
