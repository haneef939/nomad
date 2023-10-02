// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nomad/controllers/auth_controller.dart';
// import 'package:nomad/utils/constant.dart';
// import 'package:nomad/views/initial-screens/forget-password/forgetPassword.dart';
// import 'package:nomad/widgets/buttons/primary_button.dart';
// import 'package:nomad/widgets/gradientWidget.dart';
// import 'package:nomad/widgets/text-fields/emailField.dart';
// import 'package:nomad/widgets/text-fields/paswrdField.dart';
// import 'package:nomad/widgets/text-fields/textField.dart';
// import 'package:nomad/widgets/toast.dart';
// //import 'package:mystery_word/views/home/recordData.dart';
//
// class FillData extends StatefulWidget {
//   @override
//   _FillDataState createState() => _FillDataState();
// }
//
// class _FillDataState extends State<FillData> {
//   AppController appController = Get.put(AppController());
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     Color colorA = Color(0xffFFA270);
//     Color colorB = Color(0xff870000);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Color(0xffFFA270),
//           leading: IconButton(
//             icon: Image.asset(Constant.backWhiteButton),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height-80.h,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [colorA, colorB],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   child: Text(
//                     "Ale Smith",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//
//                 //document number
//                 TextxField(
//                     appController: appController,
//                     controller: appController.docNoController.value,
//                     hintText: "Document Number"),
//                 //nationality Controller
//                 TextxField(
//                     appController: appController,
//                     controller: appController.nationalityController.value,
//                     hintText: "Nationality"),
//                 //nationality Controller
//                 TextxField(
//                     appController: appController,
//                     controller: appController.dobController.value,
//                     hintText: "Date of Birth"),
//                 //gender Controller
//                 TextxField(
//                     appController: appController,
//                     controller: appController.genderController.value,
//                     hintText: "Gender"),
//                 EmailField(appController: appController),
//                 PasswordField(appController: appController),
//                 KPrimaryButton(
//                   btnText: "Save Details",
//                   onPressed: () {},
//                 ),
//
//                 // SizedBox(height: 10.h),
//                 // Text("One touch Sign in",style: TextStyle(color: Colors.white,fontSize: 20)),
//                 // SizedBox(height: 10.h),
//
//                 SizedBox(height: 30.h),
//
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.75,
//                   child: Text(
//                       "By proceeding you also agree to terms and condition",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: Colors.white.withOpacity(0.8),
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
