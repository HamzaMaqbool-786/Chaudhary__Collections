import 'package:chaudhary_collections/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgetPass_controller extends GetxController{

  FirebaseAuth auth=FirebaseAuth.instance;
  Future<void> Forget_Pass(String userEmail)async{
    try{
      EasyLoading.show(status: "Please wait..");
     await auth.sendPasswordResetEmail(email:userEmail );
      EasyLoading.dismiss();
      Get.snackbar("Request Sent Sucessfully",
        "Password reesr link sent to $userEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appConstants.secondary_color,
        colorText: appConstants.text_color,);


    }on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appConstants.secondary_color,
        colorText: appConstants.text_color,
      );
    }


  }


}