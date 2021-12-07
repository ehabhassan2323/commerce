import 'package:flutter/material.dart';
import 'package:shop_app/Layout/LayoutScreen.dart';
import 'package:shop_app/Screens/ContactUs/contactUs.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/CartModel.dart';

class ConfirmOrder extends StatefulWidget {
  CartModel model;

  ConfirmOrder(this.model);

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  @override
  void initState()
  {
    super.initState();
    Future.delayed(Duration(seconds: 4) ,page);
  }

  page()
  {
    navigateToPushReplacement(context , LayoutScreen()) ;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/log1.png',
            width: MediaQuery.of(context).size.width * .4),
        actions: [
          IconButton(
            onPressed: () {
              navigateToPush(context, ContactUs());
            },
            icon: Icon(
              Icons.perm_contact_cal,
              color: defaultColor,
              size: 35,
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/suc.gif',height:250 ,),
            SizedBox(height: 20,),
            Text('order confirmed .. We are glad to serve you',textAlign: TextAlign.center,style: TextStyle(
                fontSize: 20,
                color: defaultColor,
                fontWeight: FontWeight.w600
            ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget confirmOrder(CartData model) {
//   return Container(
//     margin: EdgeInsets.all(15),
//     height: 110,
//     width: double.infinity,
//     decoration: BoxDecoration(
//         color: Colors.grey, borderRadius: BorderRadius.circular(15)),
//     child: Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'product name:   ',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   height: 1,
//                 ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Expanded(
//                 child: Text(model.product!.name! ,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     height: 1,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,),
//               ),
//             ],
//           ),
//           Divider(
//             height: 1,
//             color: Colors.black,
//           ),
//           Row(
//             children: [
//               Text('price',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   height: 1,
//                 ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,),
//               Spacer(),
//               Text(model.product!.price.toString(),
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   height: 1,
//                 ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
