
import 'package:chaudhary_collections/screens/auth_ui/signIn(screen).dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/google_signin_controler.dart';
import '../../utils/app_constants.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  GoogleSignInController _googleSignInController=Get.put(GoogleSignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:appConstants.secondary_color ,
      appBar: AppBar(
        title: (Text("Welcome to my App",style:const TextStyle(color: appConstants.text_color,fontWeight: FontWeight.bold))),
        centerTitle: true,
        backgroundColor: appConstants.secondary_color,
      ),

      body: Column(
        children: [
          Expanded(child:
          Container(

            color: appConstants.secondary_color,
          child: Lottie.asset('assets/images/Animation - 1732735526360.json'),
          )
          ),

          Expanded(child: Container(color: Colors.white,
          margin: EdgeInsets.only(bottom: 2),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("Happy Shopping",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
              SizedBox(height: 90),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: appConstants.secondary_color,
                  borderRadius: BorderRadius.circular(20),
                  ),
                child: TextButton.icon(onPressed: (){
                  _googleSignInController.signInWithGoogle();
                }, label:Text("Signin with google",style: TextStyle(color: appConstants.text_color),),

                icon: Image.asset("assets/images/final-google-logo.png",width: 25,height: 25,),
                )


                ),
              SizedBox(height: 20,),
              Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: appConstants.secondary_color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton.icon(onPressed: (){
                    Get.to(()=>SignIN_screen());
                  }, label:Text("Signin with email",style: TextStyle(color: appConstants.text_color),),

                    icon: Icon(Icons.email,color: Colors.white,),
                  )


              ),
            ],
          ),
          )),
        ],
      ),
    );
  }
}
