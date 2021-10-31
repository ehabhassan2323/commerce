
 class CategoryModel
 {
   bool? status ;
   CategoryData? data ;

   CategoryModel.fromJson(Map<String,dynamic>json)
   {
     status=json['status'] ;
     data=CategoryData.fromJson(json['data']);
   }
 }


  class CategoryData
  {
    int? currentPage ;
    List<DataModel> data=[];

    CategoryData.fromJson(Map<String,dynamic>json)
    {
      currentPage = json['current_page'] ;
       json['data'].forEach((element){
         data.add(DataModel.fromJson(element));
       });
    }

  }

  class DataModel
  {
    int? id;
    String? name;
    String? image;

    DataModel.fromJson(Map<String,dynamic>json)
    {
      id = json['id'] ;
      name = json['name'] ;
      image = json['image'] ;
    }

  }