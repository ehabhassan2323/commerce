import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/Screens/ContactUs/contactUs.dart';
import 'package:shop_app/const/const.dart';

class Terms extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context , state){},
      builder: (context , state)
      {
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
          body: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ShopCubit.get(context).setting!.data!.terms! ,
                style: TextStyle(
                    height: 3
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
