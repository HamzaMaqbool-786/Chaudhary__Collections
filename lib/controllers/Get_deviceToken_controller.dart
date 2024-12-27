import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../utils/app_constants.dart';

class GetdeviceTokenController extends GetxController{
   String?DeviceToken;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    GetDeviceToken();
  }

  Future<void>GetDeviceToken()async{
    try {
      String? token = await FirebaseMessaging.instance.getToken();
if(token!=null){
      DeviceToken = token;
      update();}
    }on FirebaseException catch(e){
      Get.snackbar("Error", "$e",
      snackPosition: SnackPosition.BOTTOM,
    colorText: appConstants.text_color,
    backgroundColor: appConstants.secondary_color,);

  }
  }


}