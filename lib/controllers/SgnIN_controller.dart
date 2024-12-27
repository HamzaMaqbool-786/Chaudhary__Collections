import 'package:chaudhary_collections/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignIn_controller extends GetxController{
  FirebaseAuth _auth = FirebaseAuth.instance;
  // For password visibility
  var isPasswordVisible = true.obs;

  Future<UserCredential?> signInMethod(String userEmail, String userPassword) async {
    try {
      EasyLoading.show(status: "Please wait..");

      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      EasyLoading.dismiss();
      return userCredential;

    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

      // Handle specific error codes
      String errorMessage = "An error occurred. Please try again.";

      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found with this email.";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password. Please try again.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'user-disabled':
          errorMessage = "This user has been disabled. Please contact support.";
          break;
        case 'too-many-requests':
          errorMessage = "Too many requests. Please try again later.";
          break;
        case 'network-request-failed':
          errorMessage = "Network request failed. Please check your internet connection.";
          break;
        default:
          errorMessage = e.message ?? "An unknown error occurred.";
      }

      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appConstants.secondary_color,
        colorText: appConstants.text_color,
      );

      return null;
    }
  }
}
