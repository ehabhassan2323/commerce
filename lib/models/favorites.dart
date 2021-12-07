

   class ChangeFavoriteCarts
   {
     bool? status ;
     String? message ;

     ChangeFavoriteCarts.fromJson(Map<String , dynamic>json){
       status = json['status'] ;
       message = json['message'] ;
     }
   }