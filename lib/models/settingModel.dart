
class Setting
  {
    bool? status ;
    DataDetails? data ;


    Setting.fromJson(Map<String , dynamic> json){
      status = json['status'] ;
       data = DataDetails.fromJson(json['data']);
    }
  }

    class DataDetails
    {
      String? about ;
      String? terms ;

      DataDetails.fromJson(Map<String , dynamic>json)
      {
        about = json['about'];
        terms = json['terms'];
      }
    }