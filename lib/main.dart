import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/diohelper.dart';
import 'package:shop_app/Layout/LayoutScreen.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Screens/loginScreen/login.dart';
import 'package:shop_app/Screens/onboarding/On_boarding.dart';
import 'Network/sharedPerference/sharedPerference.dart';
import 'const/blocobserver.dart';
import 'const/const.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  Widget widget;
  bool? onBoarding ;
   onBoarding =CashHelper.getData('OnBoarding');
   token = CashHelper.getData('token');

  if (onBoarding != null)
  {
    if (token != null)
      widget = LayoutScreen();
    else
      widget = LoginScreen();
  }
     else
  {
       widget = OnBoarding();
  }

    runApp(MyApp(startScreen: widget,));


}


class MyApp extends StatelessWidget {
  final Widget startScreen;

  MyApp({
    required this.startScreen,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..categoryData()..getFavorites()..getProfile()..getSetting().. getContact(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
            textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontSize: 18,
                  color: Colors.white
              ),
            ),
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.grey,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.grey,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: defaultColor,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: darkColor,
              backgroundColor: Colors.grey,
            ),
            appBarTheme: AppBarTheme(
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: darkColor,
                  statusBarIconBrightness: Brightness.light
              ),
              backgroundColor: darkColor,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 25,

              ),
            )
        ),
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: defaultColor,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: darkColor,
              type: BottomNavigationBarType.fixed,
            ),

            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: defaultColor,
              ),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white,
              ),
              backgroundColor: Colors.white,
              textTheme: TextTheme(
                  headline6: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: darkColor,
                      fontSize: 25
                  )
              ),
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: darkColor,
                fontSize: 25,
              ),
            )

        ),
        home: startScreen,

      ),
    );
  }
}
