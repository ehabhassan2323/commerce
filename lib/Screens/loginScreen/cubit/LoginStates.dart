
import 'package:shop_app/models/LoginModel.dart';

abstract class LoginStates {}
 // login States......
 class LoginInitialState extends LoginStates {}
 class LoginLoadingState extends LoginStates {}
 class LoginSuccessState extends LoginStates {
 final LoginModel loginModel ;

  LoginSuccessState(this.loginModel);

 }
 class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
 }

 // show password
class LoginShowPasswordState extends LoginStates {}


