import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/Screens/ContactUs/contactUs.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/homeModel.dart';

class TakeIt extends StatelessWidget {
  final ProductsModel model;

  var form = GlobalKey<FormState>();


  TakeIt(this.model);

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/log1.png',
              width: 180,
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
                      height: 20,
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
                      height: 10,
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

                      },
                    ),
                    SizedBox(height: 30,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          Image.network(model.image!,height: 150, width: 150,fit:BoxFit.fill,),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text('Name Product:'),
                              Spacer(),
                              Expanded(child: Text(model.name!,
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
                          Divider(height: 10,),
                          Row(
                            children: [
                              Text('Price:'),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(model.price.toString(),
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                            ],
                          ),
                          Divider(height: 10,),
                          Row(
                            children: [
                              Text('delivery:'),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(cubit.delivery.toString(),
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 10,),
                          Row(
                            children: [
                              Text('total:'),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '${model.price + cubit.delivery}',
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 10,)

                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    button(
                      onPress: ()
                      {
                        if(form.currentState!.validate())
                          {

                          }
                      },
                      name: 'Confirm',
                    ),
                  ],
                ),
              ),
            ),),
        );
      },

    );
  }
}
