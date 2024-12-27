import 'package:cached_network_image/cached_network_image.dart';
import 'package:chaudhary_collections/models/categories_model.dart';
import 'package:chaudhary_collections/screens/user_panel/SingleCategoryProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class Categorywidget extends StatefulWidget {
  const Categorywidget({super.key});

  @override
  State<Categorywidget> createState() => _CategorywidgetState();
}

class _CategorywidgetState extends State<Categorywidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: FirebaseFirestore.instance.collection("categories").get(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
      if(snapshot.hasError){
        return Container(child: Center(child: Text("Error")),);
      }
      if(snapshot.connectionState==ConnectionState.waiting){
        return Container(
          child: Center(child: CupertinoActivityIndicator(),),
        );

      }
      if(snapshot.data!.docs.isEmpty){
        return Container(
          child: (
          Center(
            child: Text("No categories present"),
          )
          ),
        );
      }

      if(snapshot.hasData)
      {
        return Container(
          height: Get.height/5,
          child: ListView.builder(
            shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.horizontal,

              itemBuilder: (BuildContext context,index){
                var Categories=CategoriesModel(categoryId: snapshot.data?.docs[index]["categoryId"],
                    categoryImg:snapshot.data?.docs[index]["categoryImg"],
                    categoryName: snapshot.data?.docs[index]["categoryName"],
                    createdAt: snapshot.data?.docs[index]["createdAt"],
                    updatedAt: snapshot.data?.docs[index]["updatedAt"],
                );

            return Container(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: ()=>Get.to(()=>AllSingleCategoryProductsScreen(categoryName:Categories.categoryName)),
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: FillImageCard(
                        borderRadius: 20.0,
                        width: Get.width / 4.0,
                        heightImage: Get.height / 10,
                        imageProvider: CachedNetworkImageProvider(Categories.categoryImg),
                        title: Center(child: Text(Categories.categoryName)),

                      ),
                    ),
                  ),

                ],
              ),
            );
          }),

        );


      }
      return Container();
        });
  }
}
