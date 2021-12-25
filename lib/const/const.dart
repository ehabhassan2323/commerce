import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Network/sharedPerference/sharedPerference.dart';
import 'package:shop_app/Screens/loginScreen/login.dart';

Color defaultColor = Colors.deepOrange;
Color darkColor = Colors.grey;

 void navigateToPush(context,widget)
   {
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>widget)) ;
   }
void navigateToPushReplacement(context,widget)
{
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>widget)) ;
}

Widget textForm(
    {
   Icon? perfixIcon ,
   IconData? sufixIcon ,
 required TextInputType type ,
  var validator ,
  required TextEditingController controller ,
   String? label,
  bool secureText = false,
      var onSubmit ,
      var onChange ,
      var suffixPressed,
      String? hint ,

})=>TextFormField(
  onChanged: onChange,
  onFieldSubmitted:onSubmit ,
  validator: validator,
  controller:controller ,
  keyboardType: type,
  obscureText:secureText  ,
  decoration : InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    prefixIcon: perfixIcon,
    suffixIcon: IconButton(
      onPressed: suffixPressed,
        icon: Icon(sufixIcon),
    ),
    labelText: label ,
    hintText: hint,
  ),
);

   Widget button({
     required var onPress ,
     required String name,
     Color  color =  Colors.deepOrange ,
     double width =double.infinity
   })=> Container(
     width: width,
     height: 60,
     child: ElevatedButton(
       onPressed:onPress,
       child: Text(name),
       style: TextButton.styleFrom(
         shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25) ),
         backgroundColor: color,
         textStyle: TextStyle(
           color: Colors.white,
           fontSize:20
         ),
       ),
     ),
   );

  Widget circleAvatar({
  required var onPress,
    double size = 25 ,
    required String imageName,

})=> GestureDetector(
    onTap: onPress,
  child:   CircleAvatar(

      maxRadius: size,
      backgroundColor: Colors.white,
      child: Image.asset(imageName,),
    ),
);

class CustomDialog extends StatelessWidget {
  final  String? title,description,textButton ;
  final  Image? image;
  CustomDialog({this.image,this.title,this.description,this.textButton,});
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child :dialogContent(context)
    );
  }

  dialogContent(BuildContext context )
  {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 100, left: 16, bottom: 16, right: 16,),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0.0,10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title!,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20,),
              Text(description!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20,),
              TextButton(
                  onPressed: ()
                  {
                    navigateToPushReplacement(context, LoginScreen());
                  },
                  child: Text('Sign in ',style: TextStyle(color: defaultColor),)
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 60,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset('assets/suc.gif',)),
          ),
        ),
      ],
    );
  }
}

 void showToast({
   required String msg ,
    Color color = Colors.deepOrange ,

}) =>  Fluttertoast.showToast(
     msg: msg,
     toastLength: Toast.LENGTH_SHORT,
     gravity: ToastGravity.CENTER,
     timeInSecForIosWeb: 1,
     backgroundColor:color,
     textColor: Colors.white,
     fontSize: 16.0
 );

 Widget bottomNavyBar(context)
 {
   ShopCubit cubit = BlocProvider.of(context);
   return BottomNavyBar(

     containerHeight: 80,
     showElevation: false,
     iconSize: 30,
     itemCornerRadius: 15,
     selectedIndex: cubit.currentIndex,
     onItemSelected: (int index) {
       cubit.changeItemButtonNavy(index);
     },
     items:<BottomNavyBarItem> [
       BottomNavyBarItem(
           textAlign: TextAlign.center,
           title: Text('Category') ,
           icon: Icon(Icons.home),
           activeColor: Colors.green,
           inactiveColor: Colors.grey
       ),
       BottomNavyBarItem(
           textAlign: TextAlign.center,
           title: Text('Product') ,
           icon: Icon(Icons.apps),
           activeColor:Colors.teal ,
           inactiveColor: Colors.grey
       ),
       BottomNavyBarItem(
           textAlign: TextAlign.center,
           title: Text('Cart') ,
           icon: Icon(Icons.shopping_cart_sharp),
           activeColor: Colors.red,
           inactiveColor: Colors.grey
       ),
       BottomNavyBarItem(

           textAlign: TextAlign.center,
           title: Text('setting') ,
           icon: Icon(Icons.settings),
           activeColor: Colors.cyan,
           inactiveColor: Colors.grey
       ),

     ],

   );
 }

   String? token = ' ' ;
  
   void signOut(context)
   {
     CashHelper.remove('token').then((value){
       if(value)
       {
         navigateToPushReplacement(context, LoginScreen());
       }

     });
   }