import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/contactModel.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/log1.png',
              width: MediaQuery.of(context).size.width*.4,
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
                  width: MediaQuery.of(context).size.width*.04
              ),
            ],
          ),
          body: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              Text('Contact Us ',
                style: TextStyle(
                    fontSize: 20,
                    color: defaultColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context , index)=> listTitle(cubit.contact!.data!.data[index],index),
                  itemCount: cubit.contact!.data!.data.length,

                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget listTitle(DataConModel model, index)
{


  List<String> name = [
    'facebook',
    'instagram',
    'twitter',
    'email',
    'call',
    'whatsapp',
    'snapchat',
    'youtube',
    'website',
  ];
  return Container(
    margin: EdgeInsets.all(10),
    height: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey[200],
    ),
    child: ListTile(
      onTap: ()async
      {
        await launch(model.value!);
      },
      title: Text(name[index]),
      trailing: Image.network(model.image!,color: defaultColor ,height: 100,width: 100,),
    ),
  );

}