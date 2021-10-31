
  class ContactUsModel
  {
    bool? status ;
    ContactData? data ;

    ContactUsModel.fromJson(Map<String , dynamic> json)
    {
      status = json['status'] ;
      data = ContactData.fromJson(json['data']) ;
    }
  }

  class ContactData
  {
    int? currentPage ;
    List<DataConModel> data=[];

    ContactData.fromJson(Map<String , dynamic>json)
    {
      currentPage= json['current_page'];
      json['data'].forEach((element){
        data.add(DataConModel.fromJson(element));

      });

    }
  }


  class DataConModel
  {
     int? id ;
     int? type ;
     String? value ; 
     String? image ;

     DataConModel.fromJson(Map<String, dynamic>json)
     {
       id = json['id'] ;
       type = json['type'] ;
       value = json['value'] ;
       image = json['image'] ;
     }

  }