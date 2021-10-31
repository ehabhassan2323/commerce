import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/LayoutScreen.dart';
import 'package:shop_app/Network/sharedPerference/sharedPerference.dart';
import 'package:shop_app/Screens/loginScreen/cubit/loginCubit.dart';
import 'package:shop_app/Screens/loginScreen/cubit/LoginStates.dart';
import 'package:shop_app/const/const.dart';
import '../register/Sign_up.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state)
          {
            if (state is LoginSuccessState) {
              if (state.loginModel.status) {
                print(state.loginModel.data!.token);
                CashHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token,
                ).then((value){
                  token = state.loginModel.data!.token ;
                  navigateToPushReplacement(context,LayoutScreen());
                }).catchError((error){
                  print('error is ${error.toString()}');
                });
              } else {
                showToast(
                  msg: state.loginModel.message!,
                );
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/log1.png',
                              height: 90,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Login  to  your  Account',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          // TextForm  email  ......
                          textForm(
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            label: 'email',
                            perfixIcon: Icon(Icons.email),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' please enter your email';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // TextForm  password  ......
                          textForm(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' please enter your password';
                              } else {
                                return null;
                              }
                            },
                            perfixIcon: Icon(Icons.lock),
                            sufixIcon: LoginCubit.get(context).showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            suffixPressed: () {
                              LoginCubit.get(context).showPass();
                            },
                            label: 'password',
                            secureText: LoginCubit.get(context).showPassword,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          // sign in button
                          Center(
                            child: ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => button(
                                color: defaultColor,
                                name: 'Login',
                                onPress: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                    print(emailController.text);
                                    print(passwordController.text);
                                  }
                                },
                              ),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            '-OR Sign in With-',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: defaultColor,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          // logo social media
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              circleAvatar(
                                onPress: () {},
                                imageName: 'assets/google.png',
                              ),
                              circleAvatar(
                                  onPress: () {}, imageName: 'assets/face.png'),
                              circleAvatar(
                                  onPress: () {},
                                  imageName: 'assets/insta.png'),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don\'t have an account ?",
                                style: TextStyle(fontSize: 15),
                              ),
                              TextButton(
                                child: Text(
                                  'sign up',
                                  style: TextStyle(
                                      color: defaultColor, fontSize: 18),
                                ),
                                onPressed: () {
                                  navigateToPushReplacement(
                                      context, SignupScreen());
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
