
import 'package:chaudhary_collections/controllers/SignUp_controller.dart';
import 'package:chaudhary_collections/screens/auth_ui/signIn(screen).dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';

import '../../controllers/Get_deviceToken_controller.dart';
import '../../utils/app_constants.dart';


class SignUp_screen extends StatefulWidget {
  const SignUp_screen({super.key});


  @override

  State<SignUp_screen> createState() => _SignUp_screenState();
}

class _SignUp_screenState extends State<SignUp_screen> {
  SignUp_controller signUp_controller=Get.put(SignUp_controller());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userName=TextEditingController();
  TextEditingController userPhone=TextEditingController();
  TextEditingController userCity=TextEditingController();

  //device token controller
  GetdeviceTokenController getdeviceTokenController=Get.put(GetdeviceTokenController());

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Sign Up",
              style: TextStyle(color: appConstants.text_color),
            ),
            backgroundColor: appConstants.secondary_color,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics:BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text("Welcome to Chaudhary Collections",
                    style:TextStyle(color: appConstants.secondary_color,fontWeight: FontWeight.bold) ,),
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
                      keyboardType: TextInputType.emailAddress,
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: userName,
                      cursorColor: appConstants.secondary_color,
                      decoration: InputDecoration(
                        hintText: "Username",
                        prefixIcon: Icon(Icons.person),
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: userPhone,
                      cursorColor: appConstants.secondary_color,
                      decoration: InputDecoration(
                        hintText: "Phone",
                        prefixIcon: Icon(Icons.phone),
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      keyboardType:TextInputType.text,
                      controller: userCity,
                      cursorColor: appConstants.secondary_color,
                      decoration: InputDecoration(
                        hintText: "City",
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
SizedBox(
  height: 15,
),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Obx(
                      ()=>Padding(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(

                          keyboardType: TextInputType.visiblePassword,
                          controller: userPassword,
                          cursorColor: appConstants.secondary_color,
                          obscureText: signUp_controller.ispassword_visible.value,
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon:GestureDetector(
                              onTap: (){
                                signUp_controller.ispassword_visible.toggle();
                              },
                              child:signUp_controller.ispassword_visible.value? Icon(Icons.visibility_off):Icon(Icons.visibility),),
                            contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                            prefixIcon: Icon(Icons.password),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: appConstants.secondary_color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment:Alignment.center,

                  child: TextButton(onPressed: ()async{
                    var name=userName.text.trim();
                    var email=userEmail.text.trim();
                    var phone=userPhone.text.trim();
                    var city=userCity.text.trim();
                    var password=userPassword.text.trim();
                    var DeviceToken=getdeviceTokenController.DeviceToken.toString();
                    if(name.isEmpty||email.isEmpty||phone.isEmpty||city.isEmpty||password.isEmpty){
                      Get.snackbar("Error","Please fill all fields",
                          backgroundColor: appConstants.secondary_color,
                          colorText: appConstants.text_color,
                           snackPosition: SnackPosition.BOTTOM       );

                    }
                    else{
                   UserCredential? userCredential=await signUp_controller.SignUpMethod(name, email,
                        phone, city, password, DeviceToken);

                    if(userCredential != null){
Get.snackbar("Verification email sent",
               "Please check your email"  ,
  snackPosition: SnackPosition.BOTTOM,
  colorText: appConstants.text_color,
  backgroundColor: appConstants.secondary_color,

);
FirebaseAuth auth=FirebaseAuth.instance;
auth.signOut();
Get.offAll(()=>SignIN_screen());


                    }


                  }},

                      child:Text("SIGN UP",
                        style: TextStyle(color:appConstants.text_color,fontWeight: FontWeight.bold),)),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Already have an account?",style: TextStyle(color: appConstants.secondary_color),),

                    InkWell(
                        onTap: (){      Get.offAll(SignIN_screen());},
                        child: Text("Sign In",style: TextStyle(color: appConstants.appMAin_color,fontWeight: FontWeight.bold))),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
