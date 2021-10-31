import 'package:flutter/material.dart';
import 'package:shop_app/Screens/DeliveryScreen/deliveryScreen.dart';
import 'package:shop_app/Screens/ContactUs/contactUs.dart';
import 'package:shop_app/Screens/HowOrder/takeit.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/homeModel.dart';

class HowOrder extends StatelessWidget {

   final ProductsModel model ;

   HowOrder( this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/log1.png', width: 180,),
        actions: [
          IconButton(
            onPressed:()
            {
              navigateToPush(context , ContactUs()) ;
            },
            icon: Icon(Icons.perm_contact_cal,color: defaultColor,size: 35,),
          ),
          SizedBox(width: 15,),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(height: 20,),
             button(
               onPress: ()
               {
                 navigateToPush(context , TakeIt(model));
               },
               name: 'take it' ,
                width: 300,
             ),
             SizedBox(height: 20,),
             button(
               onPress: ()
               {
                 navigateToPush(context , DeliveryScreen(model));
               },
               name: 'Delivery' ,
               width: 300,
             ),
           ],
        ),
      ),
    );
  }
}
