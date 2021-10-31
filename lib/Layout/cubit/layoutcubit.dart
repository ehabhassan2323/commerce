import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/diohelper.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/Network/endpoints.dart';
import 'package:shop_app/Screens/category/category.dart';
import 'package:shop_app/Screens/favorite/favourite.dart';
import 'package:shop_app/Screens/product/product.dart';
import 'package:shop_app/Screens/setting/setting.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/LoginModel.dart';
import 'package:shop_app/models/categoeyModel.dart';
import 'package:shop_app/models/contactModel.dart';
import 'package:shop_app/models/favoriteModel.dart';
import 'package:shop_app/models/favorites.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/models/settingModel.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  var customName = TextEditingController();
  var customPhone = TextEditingController();
  var customHome = TextEditingController();
  var customRoad= TextEditingController();
  var customBloc= TextEditingController();
  var customArea= TextEditingController();
  double delivery = .500 ;
  double? total ;




  List<Widget> screens = [
    CategoryScreen(),
    ProductScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];

  void changeItemButtonNavy(index) {
    currentIndex = index;
    emit(ShopChangeButtonNavState());
  }

  HomeModel? homeModel;

   ProductsModel? productsModel;

  Map<int, bool> favorite = {};


  void getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorite.addAll({
          element.id!: element.inFavorites!
        });
      });
      // print(homeModel!.data!.products[0].description);
      emit(HomeSuccessState());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(HomeErrorState());
    });
  }

  CategoryModel? categoryModel;

  void categoryData() {
    DioHelper.getData(url: CATEGORY, token: token).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(HomeSuccessCategoryState());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(HomeErrorCategoryState());
    });
  }

  ChangeFavorite? changeFavorite;

  void changeFavorites(int productId,) {
    favorite[productId] = !favorite[productId]!;
    emit(HomeChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavorite = ChangeFavorite.fromJson(value.data);
      print(value.data);
      if (!changeFavorite!.status!) {
        favorite[productId] = !favorite[productId]!;
      }
      else {
        getFavorites();
      }
      emit(HomeSuccessFavoritesState(changeFavorite!));
    }).catchError((error) {
      print('error is ${error.toString()}');
      favorite[productId] = !favorite[productId]!;
      emit(HomeErrorFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(HomeLoadingGetFavoritesState());
    DioHelper.getData(
        url: FAVORITES,
        token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(HomeSuccessGetFavoritesState());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(HomeErrorGetFavoritesState());
    });
  }

 late LoginModel userData;

  void getProfile() {
    emit(HomeLoadingProfileState());
    DioHelper.getData(
        url: PROFILE,
        token: token).then((  value) {
      userData = LoginModel.fromJson(value.data);
      emit(HomeSuccessProfileState());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(HomeErrorProfileState());
    });
  }

  Setting? setting;

  void getSetting() {
    DioHelper.getData(url: SETTINGS,).then((value) {
      setting = Setting.fromJson(value.data);
      emit(HomeSuccessSettingState());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(HomeErrorSettingState());
    });
  }


  ContactUsModel? contact;

  void getContact() {
    DioHelper.getData(url: CONTACTS,).then((value) {
      contact = ContactUsModel.fromJson(value.data) ;
      emit(HomeSuccessContactState());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(HomeErrorContactState());
    });
  }
}

