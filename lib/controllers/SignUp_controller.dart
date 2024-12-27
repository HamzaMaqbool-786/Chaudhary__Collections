import 'package:chaudhary_collections/models/user_model.dart';
import 'package:chaudhary_collections/utils/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUp_controller extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // for password visibility
  var ispassword_visible = true.obs;

  Future<UserCredential?> SignUpMethod(
      String username,
      String userEmail,
      String userPhone,
      String userCity,
      String userPassword,
      String userDeviceToken,
      ) async {
    try {
      EasyLoading.show(status: "Please wait..");

      // Create account
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // Create UserModel
      UserModel userModel = UserModel(
        uId: userCredential.user!.uid,
        username: username,
        email: userEmail,
        phone: userPhone,
        userImg: "",
        userDeviceToken: userDeviceToken,
        country: "",
        userAddress: "",
        street: "",
        isAdmin: false,
        isActive: true,
        createdOn: DateTime.now(),
        city: userCity,
      );

      // Store user information in Firestore
      await firebaseFirestore.collection("users").doc(userCredential.user!.uid.toString()).set(userModel.toMap());

      EasyLoading.dismiss();
      return userCredential;

    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

      // Handle different error codes
      String errorMessage = "An error occurred. Please try again.";
      switch (e.code) {
        case 'weak-password':
          errorMessage = "The password is too weak. Please choose a stronger password.";
          break;
        case 'email-already-in-use':
          errorMessage = "The email address is already in use by another account.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is invalid.";
          break;
        case 'operation-not-allowed':
          errorMessage = "Email/password sign-in is disabled for this project.";
          break;
        case 'user-disabled':
          errorMessage = "The user account has been disabled.";
          break;
        case 'too-many-requests':
          errorMessage = "Too many requests. Please try again later.";
          break;
        case 'network-request-failed':
          errorMessage = "Network request failed. Please check your internet connection.";
          break;
        default:
          errorMessage = e.message ?? "An unknown error occurred.";
          break;
      }

      // Show error message to user
      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appConstants.secondary_color,
        colorText: appConstants.text_color,
      );
    }
  }
}
