import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/diohelper.dart';
import 'package:shop_app/Layout/cubit/states.dart';
import 'package:shop_app/Network/endpoints.dart';
import 'package:shop_app/Network/sharedPerference/sharedPerference.dart';
import 'package:shop_app/Screens/CartScreen/CartScreen.dart';
import 'package:shop_app/Screens/category/category.dart';
import 'package:shop_app/Screens/product/product.dart';
import 'package:shop_app/Screens/setting/setting.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/CartModel.dart';
import 'package:shop_app/models/LoginModel.dart';
import 'package:shop_app/models/adresses.dart';
import 'package:shop_app/models/categoeyModel.dart';
import 'package:shop_app/models/contactModel.dart';
import 'package:shop_app/models/favoriteModel.dart';
import 'package:shop_app/models/favorites.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/models/settingModel.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());
  static ShopCubit get(context) => BlocProvider.of(context);

  bool switchValue = true ;


  int currentIndex = 0;
  //take it
  var customNameTakeIT = TextEditingController(text: CashHelper.getData('name'));
  var customPhoneTakeIT = TextEditingController(text: CashHelper.getData('phone'));


  //delivery
  var customName = TextEditingController(text:  CashHelper.getData('name') );
  var customPhone = TextEditingController(text:  CashHelper.getData('phone'));
  var customHome = TextEditingController(text:  CashHelper.getData('home'));
  var customRoad= TextEditingController(text:  CashHelper.getData('road'));
  var customBloc= TextEditingController(text:  CashHelper.getData('bloc'));
  var customArea= TextEditingController(text:  CashHelper.getData('area'));

  //Card controller
  var cardNumber= TextEditingController(text: CashHelper.getData('cardNumber'));
  var expiryMonth= TextEditingController(text: CashHelper.getData('expiryMonth'));
  var expiryYear= TextEditingController(text: CashHelper.getData('expiryYear'));


  var quantityController= TextEditingController();

  double delivery = .500 ;




  List<Widget> screens = [
    CategoryScreen(),
    ProductScreen(),
    CartScreen(),
    SettingScreen(),
  ];


  void changeItemButtonNavy(index) {
    currentIndex = index;
    emit(ShopChangeButtonNavState());
  }


  HomeModel? homeModel;

  ProductsModel? productsModel;

  Map<int, bool> favorite = {};

  Map<int, bool> cart = {};

  int? totalPerice  ;



  void getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorite.addAll( {
          element.id!: element.inFavorites!
        });
      });
      homeModel!.data!.products.forEach((element) {
        cart.addAll({
          element.id!: element.inCart!
        });
      });
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


  CartModel? cartModel ;

  CartData? model ;


  void quantity(int quantity,int id)
  {
    emit(HomeLoadingQuantityState());
     DioHelper.puttData(
         url: QUANTITY+"/$id",
         data:
         {
           'quantity':quantity
         }
         ).then((value){
           cartModel = CartModel.fromJson(value.data);
           emit(HomeSuccessQuantityState());
     }).catchError((error){
       print('error is $error');
       emit(HomeErrorQuantityState());
     });
  }

  void quantityPlus(index)
  {
     cartModel!.data!.cartItem[index].quantity = cartModel!.data!.cartItem[index].quantity! +1 ;
     emit(QuantityPlus());
  }

  void quantityMinus(index)
  {
    cartModel!.data!.cartItem[index].quantity = cartModel!.data!.cartItem[index].quantity! -1 ;
    emit(QuantityMinus());
  }


  void getCart()
  {
    emit(HomeLoadingGetCartState());
    DioHelper.getData(
      url: CART,
      token: token,
    ).then((value){
      cartModel = CartModel.fromJson(value.data);
      emit(HomeSuccessGetCartState());
    }).catchError((error){
      print('error is ${error.toString()}');
      emit(HomeErrorGetCartState());
    });
  }

   ChangeFavoriteCarts? changeCart;

  void changeCarts(int productId,) {
    cart[productId] = !cart[productId]!;
    emit(HomeLoadingCartState());
    DioHelper.postData(
      url: CART,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeCart = ChangeFavoriteCarts.fromJson(value.data);
      if (!changeCart!.status!) {
        cart[productId] = !cart[productId]!;
      }
      else {
        getCart();
      }
      emit(HomeSuccessCartState(changeCart!));
    }).catchError((error) {
      print('error is ${error.toString()}');
      cart[productId] = !cart[productId]!;
      emit(HomeErrorCartState());
    });
  }


  ChangeFavoriteCarts? changeFavorite;

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
      changeFavorite = ChangeFavoriteCarts.fromJson(value.data);
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

  void getFavorites(){
    emit(HomeLoadingGetFavoritesState());
    DioHelper.getData(
        url: FAVORITES,
        token: token
    ).then((value) {
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

 Addresses? addresses;

   void getAddresses()
   {
     DioHelper.postData(url: ADDRESSES , data:{
       'name': customName.text,
       'city': customBloc.text,
       'region': customRoad.text,
       'details': customHome.text,
       'note': customArea.text,
     }).then((value){
        addresses = Addresses.fromJson(value.data);
        print(addresses);
        emit(HomeSuccessAddressesState());
     }).catchError((error){
       print('error is ${error.toString()}');
       emit(HomeErrorAddressesState());
     });
   }

   void changeSwitch(bool value)
   {
     switchValue = value ;
     emit(ChangeSwitch());
   }


}

