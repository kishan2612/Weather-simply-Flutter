class SearchCity{
  String name;
  String url;

  SearchCity({this.name,this.url});

  factory SearchCity.fromJson(Map<String,dynamic> json){
    return SearchCity(
      name: json['name'] as String,
      url: json['url'] as String
    );
  }
}