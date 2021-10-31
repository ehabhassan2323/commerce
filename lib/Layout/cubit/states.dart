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
  final ChangeFavorite model ;

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