
class CartModel
{
  bool ? status ;
  Cart? data ;

  CartModel.fromJson(Map<String, dynamic>json)
  {
    status = json['status'] ;
    data = Cart.fromJson(json['data'] );
  }

}

class Cart
{
  List<CartData> cartItem = [] ;
  dynamic subTotal ;
  dynamic total ;


  Cart.fromJson(Map<String , dynamic> json)
  {
    json['cart_items'].forEach((element){
      cartItem.add(CartData.fromJson(element));
    });
    subTotal = json['sub_total'];
    total = json['total'];
  }
}


class CartData
{
  int? id ;
  int? quantity ;
  ProductCart? product ;

  CartData.fromJson(Map<String , dynamic> json)
  {
    id = json['id'] ;
    quantity = json['quantity'] ;
    product = ProductCart.fromJson(json['product']);
  }
}


class ProductCart
{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites ;
  bool? inCart ;

  ProductCart.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];

  }
}