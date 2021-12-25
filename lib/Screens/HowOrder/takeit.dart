import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/Network/sharedPerference/sharedPerference.dart';
import 'package:shop_app/Screens/ContactUs/contactUs.dart';
import 'package:shop_app/Screens/payScreen/payScreen.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/CartModel.dart';
import 'package:shop_app/models/homeModel.dart';




class TakeIt extends StatelessWidget {

  ProductsModel? model;
  CartModel? cart;

  TakeIt({this.model, this.cart});




  var form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/log1.png',
              width:MediaQuery.of(context).size.width*.4,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateToPush(context, ContactUs());
                },
                icon: Icon(
                  Icons.perm_contact_cal,
                  color: defaultColor,
                  size: 35,
                ),
              ),
              SizedBox(
                width:MediaQuery.of(context).size.width*.04,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height:MediaQuery.of(context).size.height*.03,

                    ),
                    Text(
                      'Order Request',
                      style: TextStyle(
                          fontSize: 20,
                          color: defaultColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height:MediaQuery.of(context).size.width*.04,
                    ),
                    textForm(
                        controller: cubit.customNameTakeIT,
                        type: TextInputType.name,
                        perfixIcon: Icon(Icons.person),
                        label: 'name',
                        validator: (value) {
                          if (value.isEmpty) {
                            return ' please enter your name ';
                          }
                        }),
                    SizedBox(
                      height:MediaQuery.of(context).size.width*.03,

                    ),
                    textForm(
                      controller: cubit.customPhoneTakeIT,
                      type: TextInputType.phone,
                      perfixIcon: Icon(Icons.phone),
                      label: 'phone',
                      validator: (value) {
                        if (value.isEmpty) {
                          return ' please enter your phone ';
                        }
                      },
                    ),
                    SizedBox(
                      height:MediaQuery.of(context).size.height*.03,
                    ),
                   Column(
                children: [
                  Container(
                    height:MediaQuery.of(context).size.height*.3,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft:Radius.circular(20)
                      ),
                    ),
                    child: ListView.builder(
                      itemBuilder:(context , index )=> productDetails(cubit.cartModel!, index,context),
                      itemCount: cubit.cartModel!.data!.cartItem.length,
                    ),
                  ),
                ],
              ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*.17,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight:Radius.circular(20)),
                            color: Colors.grey[300]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Total : ',style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20
                                  ),),
                                  Spacer(),
                                  Text(
                                    '${cubit.cartModel!.data!.total}' ,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:   MediaQuery.of(context).size.height*.01,
                              ),
                              Row(
                                children: [
                                  Text('Delivery : ',style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20
                                  ),),
                                  Spacer(),
                                  Text(
                                    cubit.delivery.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:MediaQuery.of(context).size.height*.02,
                                child: Divider(
                                  height: 1,color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Text('Total Price : ',style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20
                                  ),),
                                  Spacer(),
                                  Text(
                                    '${cubit.totalPerice =cubit.cartModel!.data!.total.toInt() +cubit.delivery.toInt()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 20,),
                    button(
                      onPress: ()  async {

                        if (form.currentState!.validate())
                        {
                          await  CashHelper.saveData(key: 'name', value: cubit.customNameTakeIT.text);
                          await CashHelper.saveData(key: 'phone', value: cubit.customPhoneTakeIT.text);
                          print(cubit.cartModel!.data!.total);
                          navigateToPush(context, PayScreen(cubit.cartModel!));
                        }
                      },
                      name: 'Confirm',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget productDetails (CartModel cart , index , context)
{
  return  Padding(
    padding: const EdgeInsets.only( top: 30, left: 15,right: 30),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
      height: MediaQuery.of(context).size.height*.14,
      width: double.infinity,
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Image.network(
                  cart.data!.cartItem[index].product!.image! ,
                  width:MediaQuery.of(context).size.width*.3,
                  height: MediaQuery.of(context).size.height*.3,
                  fit: BoxFit.fill,
                ),
              ),
              if(cart.data!.cartItem[index].product!.discount>0)
                Container(
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width*.13,
                  child: Text('Offer', style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),                ),
            ],
          ),
          SizedBox(width:MediaQuery.of(context).size.width*.01,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.data!.cartItem[index].product!.name! ,
                  style: TextStyle(
                    height: 1.6,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Spacer(),
                Row(
                  children: [
                    Text( 'price : ${cart.data!.cartItem[index].product!.price*cart.data!.cartItem[index].quantity}',
                      style: TextStyle(height: 1.4, color: defaultColor ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(width: 5,),
                    if(cart.data!.cartItem[index].product!.discount>0)
                      Text(
                        cart.data!.cartItem[index].product!.oldPrice.toString()  ,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


