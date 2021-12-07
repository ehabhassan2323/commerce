import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/ContactUs/contactUs.dart';
import 'package:shop_app/Screens/favorite/favourite.dart';
import 'package:shop_app/const/const.dart';
import 'package:url_launcher/url_launcher.dart';
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
            leading: IconButton(
              icon: Icon(Icons.favorite , size: 35,),
              onPressed: ()
              {
                navigateToPush(context , FavouriteScreen());
              },
            ),
            title: Image.asset('assets/log1.png', width: MediaQuery.of(context).size.width*.4,),
            actions: [
              IconButton(
                onPressed:()
                {
                  navigateToPush(context , ContactUs()) ;
                },
                icon: Icon(Icons.perm_contact_cal,color: defaultColor,size: 35,),
              ),
              SizedBox(width:MediaQuery.of(context).size.width*.04,),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: bottomNavyBar(context),
          floatingActionButton: circleAvatar(
              imageName: 'assets/whatsicon.png',
              size: 30,
              onPress: ()async
              {
                await launch( 'whatsapp://send?text=hello&phone=201067232357',);
              }),
        );
      },
    );
  }
}
