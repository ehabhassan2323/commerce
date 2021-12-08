import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
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

class DeliveryScreen extends StatelessWidget {
  ProductsModel? model;

  CartModel? cart;

  DeliveryScreen({this.model, this.cart});

  var form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset('assets/log1.png',
                width: MediaQuery.of(context).size.width * .4),
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
                width: 15,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: form,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text(
                      'Order Request',
                      style: TextStyle(
                          fontSize: 20,
                          color: defaultColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textForm(
                        controller: cubit.customName,
                        type: TextInputType.name,
                        perfixIcon: Icon(Icons.person),
                        label: 'name',
                        validator: (value) {
                          if (value.isEmpty) {
                            return ' please enter your name ';
                          }
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    textForm(
                        controller: cubit.customPhone,
                        type: TextInputType.phone,
                        perfixIcon: Icon(Icons.phone),
                        label: 'phone',
                        validator: (value) {
                          if (value.isEmpty) {
                            return ' please enter your phone ';
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: textForm(
                          controller: cubit.customHome,
                          type: TextInputType.number,
                          perfixIcon: Icon(Icons.home),
                          label: 'number of flat / building',
                          validator: (value) {
                            if (value.isEmpty) {
                              return ' please enter number of flat / building ';
                            }
                          }),
                    ),
                    textForm(
                        controller: cubit.customRoad,
                        type: TextInputType.number,
                        perfixIcon: Icon(Icons.add_road_rounded),
                        label: 'number of Road',
                        validator: (value) {
                          if (value.isEmpty) {
                            return ' please enter number of Road ';
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: textForm(
                          controller: cubit.customBloc,
                          type: TextInputType.number,
                          perfixIcon: Icon(Icons.add_location_alt_outlined),
                          label: ' number of bloc',
                          validator: (value) {
                            if (value.isEmpty) {
                              return ' please enter  number of bloc ';
                            }
                          }),
                    ),
                    textForm(
                        controller: cubit.customArea,
                        type: TextInputType.name,
                        perfixIcon: Icon(Icons.apartment),
                        label: 'name of area',
                        hint: 'such : Elhidd',
                        validator: (value) {
                          if (value.isEmpty) {
                            return ' please enter name of area';
                          }
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    ConditionalBuilder(
                      condition: cart!.data!.cartItem.isNotEmpty,
                      builder: (context) => Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .3,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)),
                            ),
                            child: ListView.builder(
                              itemBuilder: (context, index) => productDetails(
                                  cubit.cartModel!, index, context),
                              itemCount: cubit.cartModel!.data!.cartItem.length,
                            ),
                          ),
                        ],
                      ),
                      fallback: (context) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Image.network(
                              model!.image!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text('Name Product:'),
                                Spacer(),
                                Expanded(
                                  child: Text(
                                    model!.name!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('Price:'),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    model!.price.toString(),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('delivery:'),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    cubit.delivery.toString(),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('total:'),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    '${model!.price + cubit.delivery}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                    if (cart!.data!.cartItem.isNotEmpty)
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .17,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: Colors.grey[300]),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                  Spacer(),
                                  Text(
                                    cubit.cartModel!.data!.total.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Delivery : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                  Spacer(),
                                  Text(
                                    cubit.delivery.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .02,
                                child: Divider(
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total Price : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${cubit.totalPerice = cubit.cartModel!.data!.total.toInt() + cubit.delivery.toInt()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    button(
                      onPress: () {
                        if (form.currentState!.validate()) {
                          CashHelper.saveData(
                              key: 'name', value: cubit.customName.text);
                          CashHelper.saveData(
                              key: 'home', value: cubit.customHome.text);
                          CashHelper.saveData(
                              key: 'road', value: cubit.customRoad.text);
                          CashHelper.saveData(
                              key: 'bloc', value: cubit.customBloc.text);
                          CashHelper.saveData(
                              key: 'area', value: cubit.customArea.text);
                          cubit.getAddresses();

                          navigateToPush(context, PayScreen(cubit.cartModel!));
                        }
                      },
                      name: 'Confirm ',
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

Widget productDetails(CartModel cart, index, context) {
  return Padding(
    padding: const EdgeInsets.only(top: 30, left: 15, right: 30),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      height: MediaQuery.of(context).size.height * .14,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Image.network(
                  cart.data!.cartItem[index].product!.image!,
                  width: MediaQuery.of(context).size.width * .3,
                  height: MediaQuery.of(context).size.height * .3,
                  fit: BoxFit.fill,
                ),
              ),
              if (cart.data!.cartItem[index].product!.discount > 0)
                Container(
                  color: Colors.red,
                  width: 50,
                  child: Text(
                    'Offer',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .01,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.data!.cartItem[index].product!.name!,
                  style: TextStyle(
                    height: 1.6,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      'price : ${cart.data!.cartItem[index].product!.price}',
                      style: TextStyle(height: 1.4, color: defaultColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (cart.data!.cartItem[index].product!.discount > 0)
                      Text(
                        cart.data!.cartItem[index].product!.oldPrice.toString(),
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                        overflow: TextOverflow.ellipsis,
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeCarts(
                            cart.data!.cartItem[index].product!.id!);
                        if (!ShopCubit.get(context)
                            .cart[cart.data!.cartItem[index].product!.id!]!)
                          showToast(msg: 'deleted successfuly');
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      iconSize: 30,
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
