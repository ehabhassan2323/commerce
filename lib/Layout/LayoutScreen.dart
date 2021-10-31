import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/ContactUs/contactUs.dart';
import 'package:shop_app/const/const.dart';
import 'cubit/layoutcubit.dart';
import 'cubit/states.dart';


class LayoutScreen extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context , state){} ,
        builder: (context , state){
          ShopCubit cubit = BlocProvider.of(context);
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
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: bottomNavyBar(context)

          );
        },
      );
    }
  }
