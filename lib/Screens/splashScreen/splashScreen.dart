

import 'package:flutter/material.dart';
import 'package:shop_app/Layout/LayoutScreen.dart';
import 'package:shop_app/Screens/loginScreen/login.dart';
import 'package:shop_app/const/const.dart';

class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void  initState()
  {
    super.initState();
    Future.delayed(Duration(seconds: 5) , page) ;
  }

  page()
  {
    navigateToPushReplacement(context, token !=null?LayoutScreen():LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Image.asset('assets/log1.png' , height: 150,width: 150,),
            Text('Everything found it here', style: TextStyle(fontSize: 19,color: Colors.grey.withOpacity(.6))),
          ],
        ),
      ),
    );
  }
}
