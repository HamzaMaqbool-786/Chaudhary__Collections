
import 'package:chaudhary_collections/controllers/ForgetPassword_controller.dart';
import 'package:chaudhary_collections/controllers/Get_userData.dart';
import 'package:chaudhary_collections/controllers/SgnIN_controller.dart';
import 'package:chaudhary_collections/screens/admin_panel/Admin_screen.dart';
import 'package:chaudhary_collections/screens/user_panel/main_screen(user).dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app_constants.dart';
import 'Sign_Up.dart';

class SignIN_screen extends StatefulWidget {
  const SignIN_screen({super.key});

  @override

  State<SignIN_screen> createState() => _SignIN_screenState();
}

class _SignIN_screenState extends State<SignIN_screen> {
  Get_userData_controller get_userData_controller=Get.put(Get_userData_controller());
  SignIn_controller signIn_controller=Get.put(SignIn_controller());
  ForgetPass_controller forgetPass_controller=Get.put(ForgetPass_controller());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Sign In",
              style: TextStyle(color: appConstants.text_color),
            ),
            backgroundColor: appConstants.secondary_color,
            centerTitle: true,
          ),
          body: Column(
            children: [
              isKeyboardVisible?SizedBox.shrink():
              // Center the Lottie animation
              Container(
                width: double.infinity, // Make the container take full width
                color: appConstants.secondary_color, // Optional background
                child: Center(
                  child: Lottie.asset(
                    "assets/images/splash-icon.json",
                    height: 200, // Adjust height to fit nicely
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // Email input
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6.0),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    controller: userEmail,
                    cursorColor: appConstants.secondary_color,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),

                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),),
                SizedBox(
                  height: 15,
                ),
                // Email input
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Obx(()=>Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: userPassword,
                      cursorColor: appConstants.secondary_color,
                      obscureText:signIn_controller.isPasswordVisible.value,

                      decoration: InputDecoration(
                        hintText: "Password",
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                        prefixIcon: Icon(Icons.password),
                        suffixIcon:GestureDetector(
                          onTap: (){
                            signIn_controller.isPasswordVisible.toggle();
                          },
                          child:signIn_controller.isPasswordVisible.value? Icon(Icons.visibility_off):Icon(Icons.visibility),) ,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),)
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: ()async{
                      String Email=userEmail.text.trim();
                     await forgetPass_controller.Forget_Pass(Email);

                    },
                    child: Text("Forget Password?",style: TextStyle(fontWeight: FontWeight.bold,color: appConstants.appMAin_color),)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: appConstants.secondary_color,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment:Alignment.center,

                child: TextButton(onPressed: ()async{

                  String Email=userEmail.text.trim();
                  String Password=userPassword.text.trim();
                  if(Email.isEmpty||Password.isEmpty){
                    Get.snackbar("Error","Please fill all fields",
                        backgroundColor: appConstants.secondary_color,
                        colorText: appConstants.text_color,
                        snackPosition: SnackPosition.BOTTOM,);
                  }
                  else {
                    final userCredential = await signIn_controller
                        .signInMethod(Email, Password) ;


                    if (userCredential!=null ) {
                      if(userCredential.user!=null&& userCredential.user!.emailVerified){
                        var UserData= await get_userData_controller.getUserData(userCredential.user!.uid);
                        if( UserData![0]['isAdmin']==true)
                        {
                          Get.snackbar("Success", "Signed in successfully(Admin Pannel)!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: appConstants.text_color,);
                          Get.offAll(()=>AdminScreen());


                        }else{

                          Get.snackbar("Success", "Signed in successfully(userPanel)!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: appConstants.text_color,);
                          Get.offAll(()=>main_screen());
                        }
                      }
                      else{
                        Get.snackbar("Error", "Please verify your email.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: appConstants.secondary_color,
                          colorText: appConstants.text_color,
                        );
                      }

                    }
                    else{
                      Get.snackbar("Error", "Sign-in failed. Please try again.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: appConstants.secondary_color,
                        colorText: appConstants.text_color,);
                    }
                  }

                },
                    child:Text("SIGN IN",
                      style: TextStyle(color:appConstants.text_color,fontWeight: FontWeight.bold),)),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Don't have an account?" ,style: TextStyle(color: appConstants.secondary_color),),

                InkWell(
                    onTap: (){
                      Get.offAll(SignUp_screen());
                    },
                    child: Text("Sign Up",style: TextStyle(color: appConstants.appMAin_color,fontWeight: FontWeight.bold),),),
                ],
              ),

            ],
          ),
        );
      },
    );
  }
}


