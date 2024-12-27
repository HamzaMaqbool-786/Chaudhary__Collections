

import 'package:flutter/cupertino.dart';

class KeyboardFocus{
 static void  hide_keyboard(BuildContext context){
   FocusScopeNode currentFocus=FocusScope.of(context);
   if(!currentFocus.hasPrimaryFocus){
     currentFocus.unfocus();
   }

 }

}