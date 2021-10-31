
import 'package:shop_app/models/LoginModel.dart';

abstract class RegisterStates {}
// login States......
class RegisterInitialState extends RegisterStates {}
class RegisterLoadingState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {
  final LoginModel loginModel ;
  RegisterSuccessState(this.loginModel);
}
class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

// show password
class RegisterShowPasswordState extends RegisterStates {}


