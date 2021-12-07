import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/Screens/ProductDetails/productDetails.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/homeModel.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is HomeSuccessFavoritesState) {
            if (!state.model.status!) {
              showToast(msg: state.model.message!);
            }
          }
          if (state is HomeSuccessCartState)
          {
            if (!state.cart.status!)
            {
              showToast(msg: state.cart.message!);
            }
          }
        },
        builder: (context, state) {
          ShopCubit cubit = BlocProvider.of(context);
          return ConditionalBuilder(
              condition: cubit.homeModel != null && cubit.categoryModel != null,
              builder: (context) => productBuilder(cubit.homeModel, context),
              fallback: (context) => Center(child: CircularProgressIndicator()));
        });
  }
}

Widget productBuilder(HomeModel? model, context) => SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child: Container(
    color: Colors.grey[100],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          child: CarouselSlider(
            items: [
              Image.network(
                'https://couponrqmy.com/wp-content/uploads/2021/04/%D9%81%D9%88%D8%A7%D8%A6%D8%AF-%D8%A7%D9%84%D8%AA%D8%B3%D9%88%D9%82-%D8%A7%D9%84%D8%A7%D9%84%D9%83%D8%AA%D8%B1%D9%88%D9%86%D9%8A.jpeg',
                height: 220,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Image.network(
                'https://www.almaal.org/wp-content/uploads/2020/09/%D9%85%D9%88%D8%A7%D9%82%D8%B9-%D8%A7%D9%84%D8%AA%D8%B3%D9%88%D9%82-%D8%B9%D8%A8%D8%B1-%D8%A7%D9%84%D8%A5%D9%86%D8%AA%D8%B1%D9%86%D8%AA.png',
                height: 220,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Image.network(
                'https://alqiyady.awicdn.com/site-images/sites/default/files/alqiyady-prod/article/4/4/340031/08fd51e2a0fe4e70e484b41bfaa19ad27a191d2f-111219132500.jpeg',
                height: 220,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ],
            options: CarouselOptions(
                height: 220, autoPlay: true, viewportFraction: 1.0),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'products',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 18,
          crossAxisSpacing: 7,
          childAspectRatio: 1 / 1.6,
          crossAxisCount: 2,
          children: List.generate(
              model!.data!.products.length,
                  (index) =>
                  buildProduct(model.data!.products[index], context)),
        ),
      ],
    ),
  ),
);

Widget buildProduct(
    ProductsModel? model,
    context,
    ) {
  return InkWell(
    onTap: () {
      navigateToPush(
        context,
        ProductDetails(model!),
      );
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  model!.image!,
                  width: 140,
                  height: 150,
                  // fit: BoxFit.fill,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    width: 50,
                    child: Text('Offer', style: TextStyle(color: Colors.white)),
                  ),
              ],
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    style: TextStyle(
                      height: 1.4,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price} BD ',
                        style: TextStyle(height: 1.4, color: defaultColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style: TextStyle(
                              height: 1.3,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                          if (ShopCubit.get(context).favorite[model.id]!) {
                            showToast(msg: 'added successfuly');
                          } else {
                            showToast(msg: 'deleted successfuly');
                          }
                        },
                        iconSize: 33,
                        icon: Icon(Icons.favorite),
                        color: ShopCubit.get(context).favorite[model.id]!
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  ' Add To Cart ',
                  style: TextStyle(
                      color: defaultColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).changeCarts(model.id!);

                    if (ShopCubit.get(context).cart[model.id]!) {
                      showToast(msg: 'added successfuly');
                    }
                    else {
                      showToast(msg: 'deleted successfuly');
                    }
                  },
                  iconSize: 33,
                  icon: Icon(Icons.shopping_cart),
                  color: ShopCubit.get(context).cart[model.id]!
                      ? Colors.red
                      : Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
