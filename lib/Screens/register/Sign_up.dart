import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/LayoutScreen.dart';
import 'package:shop_app/Network/sharedPerference/sharedPerference.dart';
import 'package:shop_app/Screens/loginScreen/login.dart';
import 'package:shop_app/Screens/register/cubit/RegisterCubit.dart';
import 'package:shop_app/Screens/register/cubit/RegisterStates.dart';
import 'package:shop_app/const/const.dart';

class SignupScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

   @override
   Widget build(BuildContext context) {
     return BlocProvider(
       create: (context)=> RegisterCubit(),
       child: BlocConsumer<RegisterCubit,RegisterStates>(
         listener: (context , state)
         {
           if (state is RegisterSuccessState) {
             if (state.loginModel.status)
             {
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
         builder: (context , state){
           return Scaffold(
             appBar: AppBar(),
             body: Form(
               key: formKey,
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(15),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start ,
                     children: [
                       Image.asset('assets/log1.png',
                         height: 90,
                       ),
                       SizedBox(height:30),
                       Align(
                         alignment: Alignment.centerLeft,
                         child: Text('Create your account.',
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: defaultColor,
                           ),
                         ),
                       ),
                       SizedBox(height: 10,),
                       Row(
                         children: [
                           Text('have account?',
                             style: TextStyle(
                               fontSize: 15,
                               fontWeight: FontWeight.w500,
                               color: Colors.black,
                             ),
                           ),
                           TextButton(
                             child: Text('Sign in' , style: TextStyle(color: defaultColor , fontSize: 18),),
                             onPressed:
                                 ()
                             {
                               navigateToPushReplacement(context, LoginScreen());
                             } ,
                           ),
                         ],
                       ),
                       SizedBox(height:40),
                       textForm(
                           type: TextInputType.text,
                           controller:nameController,
                           label: 'name',
                           perfixIcon: Icon(Icons.person),
                           validator: (value)
                           {
                             if(value!.isEmpty)
                             {
                               return 'enter your name';
                             }
                             else
                             {
                               return null ;
                             }
                           }
                       ),
                       SizedBox(height: 20,),
                       textForm(
                           type: TextInputType.emailAddress,
                           controller:emailController,
                           label: 'email',
                           perfixIcon: Icon(Icons.email),
                           validator: (value)
                           {
                             if(value!.isEmpty)
                             {
                               return 'enter your email';
                             }
                             else
                             {
                               return null ;
                             }
                           }
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical:20),
                         child: textForm(
                             type: TextInputType.phone,
                             controller:phoneController,
                             label: 'phone',
                             perfixIcon: Icon(Icons.phone),
                             validator: (value)
                             {
                               if(value!.isEmpty)
                               {
                                 return 'enter your phone';
                               }
                               else
                               {
                                 return null ;
                               }
                             }
                         ),
                       ),
                       textForm(

                           sufixIcon: RegisterCubit.get(context).showPassword
                               ? Icons.visibility_off
                               : Icons.visibility,
                           suffixPressed: () {
                             RegisterCubit.get(context).showPass();
                           },
                           type: TextInputType.emailAddress,
                           controller:passwordController,
                           label: 'password',
                           secureText: RegisterCubit.get(context).showPassword,
                           perfixIcon: Icon(Icons.remove_red_eye),
                           validator: (value)
                           {
                             if(value!.isEmpty)
                             {
                               return 'enter your password';
                             }
                             else
                             {
                               return null ;
                             }
                           }
                       ),
                       SizedBox(
                         height: 30,
                       ),
                       // sign in button
                       Center(
                         child:button(
                           name: 'Sign up',
                           onPress: ()
                           {
                             if(formKey.currentState!.validate())
                             {
                              RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text ,
                              );


                               showDialog(context: context, builder: (context)=>CustomDialog(
                                 title: 'success',
                                 description: 'Thank you for Register \n your register successfuly .. please press sign in to sgin in and enter the app  ',
                               ));

                             }
                             else
                             {
                               return null ;
                             }

                           },
                         ),
                       ),
                       SizedBox(height: 20,),
                     ],
                   ),
                 ),
               ),
             ),
           );
         },
       ),
     );
   }
 }



