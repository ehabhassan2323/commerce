

  class FavoritesModel
  {
    bool? status ;
    late Data data ;

    FavoritesModel.fromJson(Map<String,dynamic> json)
    {
      status = json['status'] ;
      data =Data.fromJson(json['data'])  ;
    }
  }

  class Data
  {
    List <FavoritesData> favoritesData= [] ;
    Data.fromJson(Map<String ,dynamic>json)
    {
       json['data'].forEach((element){
         favoritesData.add(FavoritesData.fromJson(element));
       });
    }
  }


  class FavoritesData
  {
    int? id ;
    Product? product ;
    FavoritesData.fromJson(Map<String ,dynamic>json)
    {
       id = json['id'];
       product = Product.fromJson(json['product']);

    }
  }

  class Product
  {
    int? id;
    dynamic price;
    dynamic oldPrice;
    dynamic discount;
    String? image;
    String? name;
    String? description;

    Product.fromJson(Map<String, dynamic>json)
    {
      id = json['id'];
      price = json['price'];
      oldPrice = json['old_price'];
      discount = json['discount'];
      image = json['image'];
      name = json['name'];
      description = json['description'];
    }
  }