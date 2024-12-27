
import 'package:chaudhary_collections/controllers/Get_deviceToken_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import '../screens/user_panel/main_screen(user).dart';

class GoogleSignInController extends GetxController{
  final GoogleSignIn googleSignIn=GoogleSignIn(
    clientId: '192089677138-np016p2edegvldlreg0bl5iaqf109dqt.apps.googleusercontent.com',
  );
  final FirebaseAuth _auth=FirebaseAuth.instance;
  //Device Token Controller
  GetdeviceTokenController getdeviceTokenController=Get.put(GetdeviceTokenController());

  Future<void> signInWithGoogle() async {
    try {


      // Attempt to sign in with Google
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      print("Google Sign-In Result: ${googleSignInAccount?.displayName}");
      EasyLoading.show(maskType: EasyLoadingMaskType.black, status: "Please wait...");
      if (googleSignInAccount != null) {
        // Proceed with Google Sign-In authentication
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        print("Google Auth Token: ${googleSignInAuthentication.accessToken}");

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in to Firebase using the credential
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
         User? user = userCredential.user;
        print("Firebase User: ${user?.displayName}");

        if (user != null) {


          // If user is authenticated, create a UserModel and save it to Firestore
          UserModel userModel = UserModel(
            uId: user.uid,
            username: user.displayName ?? "No Name",
            email: user.email ?? "No Email",
            phone: user.phoneNumber ?? "No Phone",
            userImg: user.photoURL ?? "No Image",
            userDeviceToken: getdeviceTokenController.DeviceToken.toString(),
            country: "",
            userAddress: "",
            street: "",
            isAdmin: false,
            isActive: true,
            createdOn: DateTime.now(),
            city: '',
          );

          // Save user to Firestore
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set(userModel.toMap());
          print("User saved to Firestore");

          // Add a small delay before dismissing EasyLoading and navigating
          await Future.delayed(Duration(seconds: 1));

          // Dismiss loading and navigate to the main screen
          EasyLoading.dismiss();
          Get.offAll(() => const main_screen());
        } else {
          print("User sign-in failed.");
          EasyLoading.dismiss();
        }
      } else {
        // Google Sign-In was canceled
        EasyLoading.dismiss();
        print("Google sign-in was canceled");
      }
    } catch (e) {
      // Handle any errors and dismiss loading
      print("Error $e");
      EasyLoading.dismiss();
    }
  }
}
