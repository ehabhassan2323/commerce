import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/diohelper.dart';
import 'package:shop_app/Network/endpoints.dart';
import 'package:shop_app/Screens/register/cubit/RegisterStates.dart';
import 'package:shop_app/models/LoginModel.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());


  static RegisterCubit get(context) => BlocProvider.of(context);

  bool showPassword = true ;
  late LoginModel loginModel ;

  void showPass()
  {
    showPassword= !showPassword;
    emit(RegisterShowPasswordState());
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    } ,
      language: 'ar' ,

    ).then((value)
    {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error) {
      print('error is : ${error.toString()}');
      emit(RegisterErrorState('error is :${error.toString()}'));
    });
  }
}
