
import 'package:chaudhary_collections/screens/auth_ui/welcome_screen.dart';
import 'package:chaudhary_collections/screens/user_panel/AllProductsScreen.dart';
import 'package:chaudhary_collections/screens/user_panel/All_categories_screen.dart';
import 'package:chaudhary_collections/screens/user_panel/all_flash_sale_products.dart';
import 'package:chaudhary_collections/widgets/AllProductsWidget.dart';
import 'package:chaudhary_collections/widgets/CategoryWidget.dart';
import 'package:chaudhary_collections/widgets/Drawer.dart';
import 'package:chaudhary_collections/widgets/FlashSale_widget.dart';
import 'package:chaudhary_collections/widgets/HeadngWidget.dart';
import 'package:chaudhary_collections/widgets/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/app_constants.dart';
class main_screen extends StatelessWidget {
  const main_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

appBar: AppBar(
  iconTheme: IconThemeData(
    color: appConstants.text_color,
  ),
  systemOverlayStyle:SystemUiOverlayStyle(
    statusBarColor: appConstants.statusbar_color,
    statusBarIconBrightness:Brightness.light,
  ),
  centerTitle: true,
    actions:[],


    backgroundColor: appConstants.appMAin_color,
title:Text(appConstants.appMain_name,style: TextStyle(
  fontWeight: FontWeight.bold,color: appConstants.text_color,
),)

),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: Get.height/90,
              ),

              //Banner widget
              BannerWidget(),
              //Heading widget
              HeadingWidget(headingTitle:"Category", headingSubTitle:"According to your choice",
                  onTap:()=> Get.to(()=>AllCategoriesScreen()), buttonText:"See More>>"),
              //Category Widget
              Categorywidget(),

              HeadingWidget(headingTitle:"Flash Sale", headingSubTitle:"Enjoy it",
                  onTap:()=> Get.to(()=>AllFlashSaleProductScreen()), buttonText:"See More>>"),

                FlashSaleWidget(),
              HeadingWidget(headingTitle:"All Products",
                  headingSubTitle: "Accordng to your budget",
                  onTap:()=>Get.to(()=>Allproductsscreen()), buttonText: "See More"),

              AllProductsWidget(),

            ],
          ),
        ),

      ),


    );
  }
}
