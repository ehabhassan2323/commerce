import 'package:shop_app/Dio/diohelper.dart';
import 'Card.dart';


class CheckoutPayment
{
  static const String tokenUrl = 'https://api.sandbox.checkout.com/tokens';
  static const String paymentUrl = 'https://api.sandbox.checkout.com/payments' ;

  static const String publicKey = 'pk_test_62e68a89-ea12-441e-b4b9-4326c7c10dac' ;
  static const  String secretKey = 'sk_test_2bc68fd1-133a-441d-852f-13835cf4a226' ;

  static const Map <String , String> tokenHeader = {
    'Content-Type' : 'Application/json' ,
    'Authorization' : publicKey
  };

  static const  Map <String , String> paymentHeader = {
    'Content-Type' : 'Application/json' ,
    'Authorization' : secretKey
  };

  Future<String> _getToken (CardPayment card) async
  {
    Map<String , String> data = {
      'type' : 'card',
      'number' : card.number!,
      'expiry_month' : card.expiryMonth!,
      'expiry_year' : card.expiryYear!,
  } ;

    var res =   await DioHelper.postData(url: tokenUrl, query: tokenHeader , data: data);
    switch(res.statusCode){
      case 201 :
        var data = res.data ;
        return data['token'];
      default :
        throw Exception(' card invalid');

    }
  }


  Future<dynamic> makePayment (CardPayment card , int amount) async
  {
    String token = await  _getToken(card) ;
    print( ' token is : $token');

    Map<String,dynamic> body ={
      'source' : {
        "type": "token",
        "token":token
      },
      'amount':amount,
      'currency' : 'BHD'
    };
    var  response = await DioHelper.postData(url:paymentUrl , query: paymentHeader ,data: body);
    switch(response.statusCode){
      case 201 :
        var data = response.data ;
        print(data['amount']);
        return true ;
      default :
        throw Exception(' Payment failed please try again ');
    }
  }

}