
import 'package:chaudhary_collections/screens/auth_ui/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/app_constants.dart';
class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          systemOverlayStyle:SystemUiOverlayStyle(
            statusBarColor: appConstants.statusbar_color,
            statusBarIconBrightness:Brightness.light,
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
                onTap: ()async
                {

                  FirebaseAuth auth = FirebaseAuth.instance;
                  if (auth.currentUser != null) {
                    await auth.signOut();



                    // Navigate to the Welcome Screen after sign out
                    Get.offAll(() => WelcomeScreen());
                  } else {
                    Get.snackbar(
                      "Error",
                      "No user is logged in.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },

                child: Padding(padding:const EdgeInsets.all(8),
                    child: Icon(Icons.logout))),
          ],

          backgroundColor: appConstants.appMAin_color,
          title:Text("Admin panel"),

      ),


    );
  }
}
