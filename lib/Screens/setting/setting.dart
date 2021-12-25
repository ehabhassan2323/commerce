import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/const/const.dart';

import 'AboutUs.dart';
import 'Terms.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context) ;


    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              // color: Colors.grey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  circleAvatar(
                    onPress: () {},
                    size: 50,
                    imageName: 'assets/1.png',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ShopCubit.get(context).userData.data!.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.black26,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info_outlined,
                      color: Colors.black,
                    ),
                    title: Text(
                      ' about us',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                    ),
                    onTap: () {
                      navigateToPush(context, AboutUs());
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.privacy_tip,
                      color: Colors.black,
                    ),
                    title: Text(
                      ' Terms& condtion',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                    ),
                    onTap: () {
                      navigateToPush(context, Terms());
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(height: 1, color: Colors.grey,),
                   // Padding(
                   //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                   //   child: Row(
                   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   //     children: [
                   //       Text('language is english', style: TextStyle(
                   //         fontSize: 20,
                   //          fontWeight: FontWeight.bold
                   //       ),) ,
                   //       Switch.adaptive(
                   //         value: cubit.switchValue,
                   //         activeColor: Colors.blue,
                   //         inactiveTrackColor: Colors.grey,
                   //         inactiveThumbColor: Colors.black,
                   //         onChanged: (bool value) {
                   //           cubit.changeSwitch(value);
                   //         },
                   //       ),
                   //     ],
                   //   ),
                   // ),
                  Divider(height: 1, color: Colors.grey,),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: button(
                      onPress: () {
                        signOut(context);
                      },
                      name: ' sign out ',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
