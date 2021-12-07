import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/Screens/ContactUs/contactUs.dart';
import 'package:shop_app/Screens/loginScreen/login.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/favoriteModel.dart';

class FavouriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {

      },
      builder : (BuildContext context, Object? state){
        var cubit = ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Image.asset('assets/log1.png', width: MediaQuery.of(context).size.width*.4,),
            actions: [
              IconButton(
                onPressed:()
                {
                  navigateToPush(context , ContactUs()) ;
                },
                icon: Icon(Icons.perm_contact_cal,color: defaultColor,size: 35,),
              ),
              SizedBox(width: MediaQuery.of(context).size.width*.04,),
            ],
          ),
          backgroundColor: Colors.grey[100],
          body: token != null? cubit.favoritesModel!.data.favoritesData.isNotEmpty?ConditionalBuilder(
            condition: state is! HomeLoadingGetFavoritesState,
            builder: (context) =>  ListView.builder(
              itemBuilder: (context , index)=>  buildFavorites( cubit.favoritesModel!.data.favoritesData[index],context),
              itemCount:  cubit.favoritesModel!.data.favoritesData.length ,
            ),
            fallback: (context)=> Center(child: CircularProgressIndicator()) ,
          ):
          Center(child: Text
            ('No product in favourite',
            style: TextStyle(
              fontSize: 25,
              color: defaultColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          ):Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Please login to add your product in favourite', style: TextStyle(fontSize: 20, color: defaultColor),),
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


Widget buildFavorites(FavoritesData model , context){
  return Padding(
    padding: const EdgeInsets.only( top: 30, left: 15,right: 30),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
      height: MediaQuery.of(context).size.height*.19,
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
                  width:MediaQuery.of(context).size.width*.35,
                  height: MediaQuery.of(context).size.height*.19,
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
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product!.name! ,
                  style: TextStyle(
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height:MediaQuery.of(context).size.height*.03,),
                IconButton(
                  onPressed: ()
                  {
                    ShopCubit.get(context).changeCarts(model.product!.id!);
                  } ,
                  iconSize: 33,
                  icon: Icon(Icons.shopping_cart_sharp),
                  color: ShopCubit.get(context).cart[model.product!.id]! ? Colors.red:Colors.grey,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.product!.price.toString() ,
                      style: TextStyle(
                          color: defaultColor ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(width:  MediaQuery.of(context).size.width*.01,),
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
                        ShopCubit.get(context).changeFavorites(model.product!.id!);
                        if(!ShopCubit.get(context).cart[model.product!.id]!)
                          showToast(msg: 'deleted successfuly');
                      } ,
                      iconSize: 33,
                      icon: Icon(Icons.favorite),
                      color: ShopCubit.get(context).favorite[model.product!.id]!? Colors.red:Colors.grey,
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
