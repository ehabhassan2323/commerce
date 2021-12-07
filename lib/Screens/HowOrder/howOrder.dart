import 'package:flutter/material.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Screens/HowOrder/deliveryScreen.dart';
import 'package:shop_app/Screens/ContactUs/contactUs.dart';
import 'package:shop_app/Screens/HowOrder/takeit.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/CartModel.dart';
import 'package:shop_app/models/homeModel.dart';

class HowOrder extends StatelessWidget {

  ProductsModel? model ;
  CartModel? cart ;
  HowOrder({ this.model , this.cart });

  @override
  Widget build(BuildContext context) {

    var cubit = ShopCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/log1.png',width:MediaQuery.of(context).size.width*.4,),
        actions: [
          IconButton(
            onPressed:()
            {
              navigateToPush(context , ContactUs()) ;
            },
            icon: Icon(Icons.perm_contact_cal,color: defaultColor,size: 35,),
          ),
          SizedBox( width:MediaQuery.of(context).size.width*.04,),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:MediaQuery.of(context).size.height*.05,),
            button(
              onPress: ()
              {
                navigateToPush(context , TakeIt( model: model,cart:  cubit.cartModel,));

              },
              name: 'take it' ,
              width:MediaQuery.of(context).size.width*.7,
            ),
            SizedBox(height:MediaQuery.of(context).size.height*.05,),
            button(
              onPress: ()
              {
                navigateToPush(context , DeliveryScreen(model: model,cart: cubit.cartModel,));
              },
              name: 'Delivery' ,
              width:MediaQuery.of(context).size.width*.7,
            ),
          ],
        ),
      ),
    );
  }
}
