
  class Addresses
  {
    String? name ;
    String? city ;
    String? region ;
    String? details ;
    String? note ;

    Addresses.fromJson(Map<String ,dynamic>json)
    {
      name= json['name'];
      city= json['city'];
      region= json['region'];
      details= json['details'];
      note= json['note'];
    }

  }