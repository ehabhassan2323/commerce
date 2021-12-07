import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/models/categoeyModel.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ConditionalBuilder(
                condition: cubit.homeModel != null &&  cubit.categoryModel != null,
                builder:(context)=> ListView.builder(itemBuilder: (context, index) => buildCategory(cubit.categoryModel!.data!.data[index],context),
                    itemCount: cubit.categoryModel!.data!.data.length),
                fallback: (context) => Center(child: CircularProgressIndicator())
            ),
          ),
        );
      },
    );
  }
  Widget buildCategory(DataModel model, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*.14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:  Radius.circular(30),topRight:  Radius.circular(30)),
              image: DecorationImage(
                  image: NetworkImage(model.image!),
                  fit: BoxFit.fill
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*.06,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                color: Colors.teal[400]!.withOpacity(.5)
            ),
            child: Center(child: Text(model.name!,style:TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 20),)),
          ),
        ],
      ),
    );
  }
}

//   Widget buildListTitle(DataModel model){
//     return GestureDetector(
//       onTap: (){},
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.grey[200],
//         ),
//         child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Image.network(
//                model.image! ,
//               height: 100,
//               width: 100,
//               fit: BoxFit.fill,
//             ),
//           ),
//           SizedBox(width: 30,),
//           Text( model.name! , style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//           Spacer(),
//           Icon(Icons.arrow_forward_ios),
//         ],
//   ),
//       ),
//     );
//   }
// }
