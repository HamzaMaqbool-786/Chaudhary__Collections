import 'package:chaudhary_collections/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';

import '../screens/auth_ui/welcome_screen.dart';
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(top: Get.height/25) ,
      child:  Drawer(
        backgroundColor: appConstants.appMAin_color,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight:Radius.circular(20),
              bottomRight:Radius.circular(20)),
        ),
        child: Wrap(
          runSpacing: 10,

          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Text("H",style: TextStyle(color: appConstants.text_color,fontWeight: FontWeight.bold),
                ),
                  backgroundColor: appConstants.secondary_color

              ),
              title: Text("HAMZA CH",style: TextStyle(color: appConstants.text_color),),
              subtitle: Text("Version 1.0.1",style: TextStyle(color: appConstants.text_color),),
            ),
            Divider(
              color:  Colors.grey,
              thickness: 2,
              endIndent: 10,
              indent: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10) ,
              child: ListTile(

                leading: Icon(Icons.home,color: appConstants.text_color,),
                title: Text("Home",style: TextStyle(color: appConstants.text_color,),),
                trailing: Icon(Icons.arrow_forward,color: appConstants.text_color,),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10) ,
              child: ListTile(

                leading: Icon(Icons.production_quantity_limits,color: appConstants.text_color,),
                title: Text("Products",style: TextStyle(color: appConstants.text_color,),),
                trailing: Icon(Icons.arrow_forward,color: appConstants.text_color,),
              ),
            ),    Padding(
              padding: EdgeInsets.symmetric(horizontal: 10) ,
              child: ListTile(

                leading: Icon(Icons.shopping_bag,color: appConstants.text_color,),
                title: Text("Orders",style: TextStyle(color: appConstants.text_color,),),
                trailing: Icon(Icons.arrow_forward,color: appConstants.text_color,),
              ),
            ),    Padding(
              padding: EdgeInsets.symmetric(horizontal: 10) ,
              child: ListTile(

                leading: Icon(Icons.contact_support_rounded,color: appConstants.text_color,),
                title: Text("Contacts",style: TextStyle(color: appConstants.text_color,),),
                trailing: Icon(Icons.arrow_forward,color: appConstants.text_color,),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10) ,
              child: ListTile(
onTap:()async {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn=GoogleSignIn();
  await auth.signOut();
  await googleSignIn.signOut();

  // Navigate to the Welcome Screen after sign out
  Get.offAll(() => WelcomeScreen());
},
                leading: Icon(Icons.logout_outlined,color: appConstants.text_color,),
                title: Text("Logout",style: TextStyle(color: appConstants.text_color,),),
                trailing: Icon(Icons.arrow_forward,color: appConstants.text_color,),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
