import 'package:shop_app/models/CartModel.dart';
import 'package:shop_app/models/favorites.dart';

abstract class ShopStates{}

class ShopInitState extends ShopStates{}
class ShopChangeButtonNavState extends ShopStates{}

//layout States
class HomeLoadingState extends ShopStates{}
class HomeSuccessState extends ShopStates{}
class HomeErrorState extends ShopStates{}
//Category States
class HomeSuccessCategoryState extends ShopStates{}
class HomeErrorCategoryState extends ShopStates{}


//  favorites states
class HomeSuccessFavoritesState extends ShopStates{
   ChangeFavoriteCarts model ;
  HomeSuccessFavoritesState(this.model);
}
class HomeChangeFavoritesState extends ShopStates{}
class HomeErrorFavoritesState extends ShopStates{}

//get favorites
class HomeLoadingGetFavoritesState extends ShopStates{}
class HomeSuccessGetFavoritesState extends ShopStates{}
class HomeErrorGetFavoritesState extends ShopStates{}

//  pass data
class PassData extends ShopStates{}


//  get profile
class HomeLoadingProfileState extends ShopStates{}
class HomeSuccessProfileState extends ShopStates{}
class HomeErrorProfileState extends ShopStates{}


// SETTING
class HomeSuccessSettingState extends ShopStates{}
class HomeErrorSettingState extends ShopStates{}

//Contact
// SETTING
class HomeSuccessContactState extends ShopStates{}
class HomeErrorContactState extends ShopStates{}


//get Cart
class HomeLoadingGetCartState extends ShopStates{}
class HomeSuccessGetCartState extends ShopStates{}
class HomeErrorGetCartState extends ShopStates{}


//get Cart
class HomeLoadingCartState extends ShopStates{}
class HomeSuccessCartState extends ShopStates{
   ChangeFavoriteCarts cart ;
  HomeSuccessCartState(this.cart);
}
class HomeErrorCartState extends ShopStates{}

// quantity
class Plus extends ShopStates{}
class Minus extends ShopStates{}

//
class HomeSuccessAddressesState extends ShopStates{}
class HomeErrorAddressesState extends ShopStates{}