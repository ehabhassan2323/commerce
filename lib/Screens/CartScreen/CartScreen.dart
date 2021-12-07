import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/Screens/HowOrder/howOrder.dart';
import 'package:shop_app/Screens/loginScreen/login.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/CartModel.dart';
import 'package:shop_app/models/homeModel.dart';

class CartScreen extends StatelessWidget {


  ProductsModel? model ;
  @override
  Widget build(BuildContext context){

    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {
          if (state is HomeSuccessCartState) {
            if (!state.cart.status!) {
              showToast(msg: state.cart.message!);
            }
          }
        },
      builder : (BuildContext context, Object? state){
        var cubit = ShopCubit.get(context);
        return  Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor:Colors.grey[100],
          ),
          body: token != null? cubit.cartModel!.data!.cartItem.isNotEmpty?Column(
            children:[
              ConditionalBuilder(
                condition: state is! HomeLoadingGetCartState,
                builder: (context) =>  Expanded(
                  child: ListView.builder(
                    itemBuilder: (context , index)=>  buildCart(cubit.cartModel!.data!.cartItem[index], context),
                    itemCount:  cubit.cartModel!.data!.cartItem.length ,
                  ),
                ),
                fallback: (context)=> Center(child: CircularProgressIndicator()) ,
              ),
              if( cubit.cartModel!.data!.cartItem.isNotEmpty)
              Container(
                margin: EdgeInsets.all(30),
                child: button(
                  name: 'Order  ' ,
                  onPress: ()
                  {
                    navigateToPush(context, HowOrder(model: model , cart:cubit.cartModel ));

                  },
                ),
              ),
            ],

          ):
          Center(child: Text(
              'No product in cart' ,
            style: TextStyle(
              fontSize: 25,
              color: defaultColor ,
              fontWeight: FontWeight.w500
            ),
          ),
          ):Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Please login to add your product in cart', style: TextStyle(fontSize: 20, color: defaultColor),),
                SizedBox(height: 30,),
                button(
                  name: 'login',
                  width: 160,
                  onPress: (){
                    navigateToPush(context, LoginScreen());
                  }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


Widget buildCart(CartData model , context){

  return  Padding(
    padding: const EdgeInsets.only( top: 30, left: 15,right: 30),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
      height: 150,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Image.network(
                  model.product!.image! ,
                  width: MediaQuery.of(context).size.width*.3,
                  height:  MediaQuery.of(context).size.height*.3,
                  fit: BoxFit.fill,
                ),
              ),
              if ( model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  width:  MediaQuery.of(context).size.width*.12,
                  child: Text('Offer', style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                ),
            ],
          ),
          SizedBox(width:  MediaQuery.of(context).size.width*.01,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product!.name! ,
                  style: TextStyle(
                    height: 1.4,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height:MediaQuery.of(context).size.height*.01),
                Row(
                  children: [
                    TextButton(
                      onPressed: ()
                      {
                      },
                      child: Text('-',style: TextStyle(
                          fontSize: 30
                      ),),
                    ),
                    SizedBox(width:MediaQuery.of(context).size.width*.01),
                    Text(
                      model.quantity.toString(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: ()
                      {

                      },
                      child: Text('+', style: TextStyle(
                          fontSize: 30
                      ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children:[
                    Text(
                      model.product!.price.toString() ,
                      style: TextStyle(color: defaultColor ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(width: 5,),
                    if ( model.product!.discount > 0)
                      Text(
                        '${model.product!.oldPrice}' ,
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                        overflow: TextOverflow.ellipsis,
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeCarts(model.product!.id!);
                        if(!ShopCubit.get(context).cart[model.product!.id]!)
                          showToast(msg: 'deleted successfuly');
                      } ,
                      iconSize: 33,
                      icon: Icon(Icons.delete),
                      color: ShopCubit.get(context).cart[model.product!.id]! ? Colors.red:Colors.grey,
                    )
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




