class CityForecast{
  String _city;

  CityForecast(this._city);

  

//explicit getter and setter
  String get cityname => _city;
  set cityname(String city)=> this._city=city;
}