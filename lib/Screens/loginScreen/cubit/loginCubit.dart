import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/diohelper.dart';
import 'package:shop_app/Network/endpoints.dart';
import 'package:shop_app/Screens/loginScreen/cubit/LoginStates.dart';
import 'package:shop_app/models/LoginModel.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());


  static LoginCubit get(context) => BlocProvider.of(context);

  bool showPassword = true ;
   late LoginModel loginModel ;

   void showPass()
    {
      showPassword= !showPassword;
      emit(LoginShowPasswordState());
    }

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    } ,
       language: 'ar' ,

    ).then((value)
    {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print('error is : ${error.toString()}');
      emit(LoginErrorState('error is :${error.toString()}'));
    });
  }
}
