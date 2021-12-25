import 'package:flutter/material.dart';
import 'package:shop_app/Layout/cubit/layoutcubit.dart';
import 'package:shop_app/Network/sharedPerference/sharedPerference.dart';
import 'package:shop_app/Screens/ContactUs/contactUs.dart';
import 'package:shop_app/Screens/confimOrder/confirmOrder.dart';
import 'package:shop_app/const/const.dart';
import 'package:shop_app/models/Card.dart';
import 'package:shop_app/models/CartModel.dart';
import 'package:shop_app/models/checkout_payment.dart';


class PayScreen extends StatefulWidget {

  final CartModel model ;
  PayScreen( this.model);

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  var form = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    var cubit = ShopCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/log1.png', width:MediaQuery.of(context).size.width*.4),
        actions: [
          IconButton(
            onPressed:()
            {
              navigateToPush(context , ContactUs()) ;
            },
            icon: Icon(Icons.perm_contact_cal,color: defaultColor,size: 35,),
          ),
          SizedBox(width: 15,),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text('Payment',style: TextStyle(
                    fontSize:20 ,
                    fontWeight: FontWeight.bold,
                    color: defaultColor,
                  ),
                  ),
                ),
                textForm(
                    controller: cubit.cardNumber,
                    type: TextInputType.number,
                    label: 'Card Number',
                    perfixIcon: Icon(Icons.credit_card),
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'Please enter card number';
                      }
                    }

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:20),
                  child: textForm(
                      controller: cubit.expiryMonth,
                      type: TextInputType.number,
                      label: 'Expiry_Month',
                      perfixIcon: Icon(Icons.calendar_view_month),
                      validator: (value)
                      {
                        if(value.isEmpty)
                        {
                          return 'Please enter Expiry_month';
                        }
                      }

                  ),
                ),
                textForm(
                    controller: cubit.expiryYear,
                    type: TextInputType.number,
                    label: 'Expiry_Year',
                    perfixIcon: Icon(Icons.calendar_today),
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'Please enter Expiry_Year';
                      }
                    }
                ),
                SizedBox(height: 20,) ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('total price' , style: TextStyle(
                      fontSize:20 ,
                      fontWeight: FontWeight.bold,
                      color: defaultColor,
                    ),),
                    Text(widget.model.data!.total.toString() , style: TextStyle(
                      fontSize:20 ,
                      fontWeight: FontWeight.bold,
                      color: defaultColor,
                    )),
                  ],
                ),
                SizedBox(height: 20,),
                button(
                    name: 'Pay' ,
                    onPress: ()
                    {
                          if(form.currentState!.validate())
                          {
                            CashHelper.saveData(
                                key: 'cardNumber', value: cubit.cardNumber.text);
                            CashHelper.saveData(
                                key: 'expiryMonth', value: cubit.expiryMonth.text);
                            CashHelper.saveData(
                                key: 'expiryYear', value: cubit.expiryYear.text);
                            CardPayment card = CardPayment(
                              CashHelper.getData('cardNumber'),
                              CashHelper.getData('expiryMonth'),
                              CashHelper.getData('expiryYear'),
                            );

                            CheckoutPayment payment = CheckoutPayment();
                            payment.makePayment(card, cubit.totalPerice!);
                            navigateToPushReplacement(context, ConfirmOrder(cubit.cartModel!));
                          }


                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
