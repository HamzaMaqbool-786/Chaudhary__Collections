import 'dart:async';
import 'dart:ui';

import 'package:chaudhary_collections/screens/auth_ui/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/Get_userData.dart';
import '../../utils/app_constants.dart';
import '../admin_panel/Admin_screen.dart';
import '../user_panel/main_screen(user).dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      loggdin(context);
    });
  }

  Future<void> loggdin(BuildContext context) async {
    if (user != null) {
      final Get_userData_controller getUserDataController =
      Get.put(Get_userData_controller());
      var userData = await getUserDataController.getUserData(user!.uid);

      print('Fetched User Data: $userData'); // Debugging

      if (userData.isNotEmpty && userData[0]['isAdmin'] == true) {
        Get.offAll(() => AdminScreen());
      } else if (userData.isNotEmpty) {
        Get.offAll(() => main_screen());
      } else {
        print('User data is empty or invalid.');
        Get.offAll(() => WelcomeScreen());
      }
    } else {
      print('User is not logged in.');
      Get.to(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.secondary_color,
      appBar: AppBar(
        backgroundColor: appConstants.secondary_color,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: Get.width,
              alignment: Alignment.center,
              child: Lottie.asset('assets/images/splash-icon.json'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            width: Get.width,
            alignment: Alignment.center,
            child: Text(
              appConstants.appPowerd_by,
              style: TextStyle(
                  color: appConstants.text_color,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
