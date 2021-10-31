import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/Screens/HowOrder/howOrder.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/homeModel.dart';

class ProductDetails extends StatelessWidget {
  final ProductsModel model;

  const ProductDetails(this.model);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .6,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(model.image!),
                        fit: BoxFit.fill,
                      )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40)),
                          color: Colors.grey[200]!.withOpacity(.9)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              model.name!,
                              style: TextStyle(
                                color: defaultColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            iconSize: 35,
                            icon:Icon(Icons.favorite),
                            color: ShopCubit.get(context).favorite[model.id]!? Colors.red:Colors.grey,
                            onPressed:()
                            {
                              ShopCubit.get(context).changeFavorites(model.id!);
                            } ,
                          ),
                        ],
                      ),
                    ),
                    // ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                    color: Colors.grey[200]!.withOpacity(.9),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Price: ',
                          style: TextStyle(
                            fontSize: 25,
                            color: defaultColor,
                          ),
                          ),
                          Text(model.price.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            color: defaultColor,
                          ),
                          ),
                          if(model.discount>0)
                          Text(model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                          ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      button(onPress: ()
                      {
                        navigateToPush(context , HowOrder(model));
                      },
                          name:'Order it ',
                          width: 300),
                      SizedBox(height: 20,),
                      Text('Description : ',
                        style: TextStyle(
                          fontSize: 20,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(height: 10,),
                      ReadMoreText(
                          model.description!,
                        style: TextStyle(
                            color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                        ),
                       lessStyle: TextStyle(
                         color: defaultColor,
                         fontSize: 20,
                         fontWeight: FontWeight.bold
                       ),
                       moreStyle:TextStyle(
                         color: defaultColor,
                         fontSize: 15,
                         fontWeight: FontWeight.bold
                       ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Column(
// children: [
// SizedBox(height: 30,child: Container(color:Colors.white ,),),
// Container(
// width: double.infinity,
// height: 250,
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.black26,
// blurRadius: 20,
// offset: Offset(0.0, 2.0),
// ),
// ],
// borderRadius: BorderRadius.circular(40),
// color: Colors.white,
// image: DecorationImage(
// fit: BoxFit.fill,
// image: NetworkImage(model.image!,
// ),
// ),
// ),
// ),
// SizedBox(height: 10,),
// Text(model.name!,
// style: TextStyle(
// fontSize: 18,
// fontWeight: FontWeight.w500,
// ),
// maxLines: 4,
// overflow: TextOverflow.ellipsis,
// ),
// SizedBox(height: 10,),
// Text('Price : ${model.price}',
// style: TextStyle(height: 1.4,
// fontSize: 20,
// fontWeight: FontWeight.bold,
// color: defaultColor),
// overflow: TextOverflow.ellipsis,
// maxLines: 2,
// ),
// if(model.discount !=0)
// Text(model.oldPrice.toString(),
// style: TextStyle(height: 1.4,
// fontSize: 15,
// decoration: TextDecoration.lineThrough,
// fontWeight: FontWeight.bold,
// color: Colors.grey),
// overflow: TextOverflow.ellipsis,
// maxLines: 2,
// ),
// SizedBox(height: 10,),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// SizedBox(width: 50,),
// Text('Add to favorite  >   ',
// style: TextStyle(height: 1.4,
// fontSize: 20,
// fontWeight: FontWeight.w500,
// color: Colors.red),
// overflow: TextOverflow.ellipsis,
// maxLines: 2,
// ),
// IconButton(
// onPressed: ()
// {
// ShopCubit.get(context).changeFavorites(model.id!);
// } ,
// iconSize: 33,
// icon: Icon(Icons.favorite),
// color: ShopCubit.get(context).favorite[model.id]!? Colors.red:Colors.grey,
// )
// ],
// ),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20),
// child: button(
// name: 'make Order',
// onPress: ()
// {
// navigateToPush(context , HowOrder(model));
// } ,
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(10),
// child: Align(
// alignment: Alignment.centerRight,
// child: ReadMoreText(
// model.description!, style: TextStyle(fontSize: 20, color: Colors.black), delimiterStyle: TextStyle(color: Colors.black, fontSize: 15,
// fontWeight: FontWeight.w500,
// ),
// ),
// ),
// ),
// SizedBox(height: 20,),
// ],
// ),
