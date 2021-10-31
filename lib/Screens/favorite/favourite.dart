import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/favoriteModel.dart';

class FavouriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (BuildContext context, state) {  },
        builder : (BuildContext context, Object? state){
          var cubit = ShopCubit.get(context);
        return  Scaffold(
          backgroundColor: Colors.grey[100],
          body:ConditionalBuilder(
               condition: state is! HomeLoadingGetFavoritesState,
                 builder: (context) =>  ListView.builder(
              itemBuilder: (context , index)=> buildFavorites( cubit.favoritesModel!.data.favoritesData[index] , context),
              itemCount:cubit.favoritesModel!.data.favoritesData.length ,
              ),
                 fallback: (context)=> Center(child: CircularProgressIndicator()) ,
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
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              if ( model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  width: 50,
                  child: Text('Offer', style: TextStyle(color: Colors.white)),
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
                    height: 1.4,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.product!.price.toString() ,
                      style: TextStyle(height: 1.4, color: defaultColor ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(width: 5,),
                    if ( model.product!.discount > 0)
                      Text(
                        '${model.product!.oldPrice}' ,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                        overflow: TextOverflow.ellipsis,
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.product!.id!);
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

// ConditionalBuilder(
//                 condition: state is! HomeLoadingGetFavoritesState,
//                 builder: (context) =>  ListView.separated(
//                   itemBuilder: (context , index)=> buildFavorites( cubit.favoritesModel!.data.favoritesData[index] , context),
//                   separatorBuilder:(context , index)=>SizedBox(height: 0,),
//                   itemCount:cubit.favoritesModel!.data.favoritesData.length ,
//                 ),
//                 fallback: (context)=> Center(child: CircularProgressIndicator()) ,
//               ),