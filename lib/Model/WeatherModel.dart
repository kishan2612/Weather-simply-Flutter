
final String city="city";
final String country="country";
final String time="time";
final String temperature="temp";
final String pressure="pressure";
final String humidity="humidity";
final String wind="wind";
final String climate="climate";
final String dayoneTime="dayoneTime";
final String dayoneTepmp="dayoneTemp";
final String dayoneClimate="dayoneClimate";
final String daytwoTime="daytwoTime";
final String daytwoTepmp="daytwoTemp";
final String daytwoClimate="daytwoClimate";
final String daythreeTime="daythreeTime";
final String daythreeTepmp="daythreeTemp";
final String daythreeClimate="daythreeClimate";
final String dayfourTepmp="dayfourTemp";
final String dayfourClimate="dayfourClimate";

class CurrentWeatherModel {
Location location;
CurrentWeather currentWeather;
Forecast forecast;

CurrentWeatherModel({this.location,this.currentWeather,this.forecast});

Map<String,dynamic> toMap(){
  var map= <String,dynamic>{
    city:location.city,
    country:location.country,
    time:location.time,
    temperature:currentWeather.temperature,
    wind:currentWeather.wind,
    pressure:currentWeather.pressure,
    humidity:currentWeather.humidity,
    climate:currentWeather.condition.climate,
    dayoneTime:forecast.forecastDay.elementAt(1).time,
    dayoneTepmp:forecast.forecastDay.elementAt(1).day.avgTemp_C,
    dayoneClimate:forecast.forecastDay.elementAt(1).day.condition.code,
    daytwoTime:forecast.forecastDay.elementAt(2).time,
    daytwoTepmp:forecast.forecastDay.elementAt(2).day.avgTemp_C,
    daytwoClimate:forecast.forecastDay.elementAt(2).day.condition.code,
    daythreeTime:forecast.forecastDay.elementAt(3).time,
    daythreeTepmp:forecast.forecastDay.elementAt(3).day.avgTemp_C,
    daythreeClimate:forecast.forecastDay.elementAt(3).day.condition.code

  };
  return map;
}

factory CurrentWeatherModel.fromJson(Map<String,dynamic> rootJson){
  return CurrentWeatherModel(
    location: Location.fromJson(rootJson['location']),
    currentWeather: CurrentWeather.fromJson(rootJson['current']),
    forecast: Forecast.fromJson(rootJson['forecast'])
  );
}

}

class Location {
  String city;
  String country;
  String time;
  Location({this.city,this.country,this.time});

  factory Location.fromJson(Map<String,dynamic> jsonA){
    return Location(
      city: jsonA['name'] as String,
      country: jsonA['country'] as String,
      time: jsonA['localtime'] as String
    );
  }
}
class CurrentWeather{
  double temperature;
  double wind;
  double pressure;
  int humidity;
  Condition condition;
  CurrentWeather({this.temperature,this.wind,this.pressure,this.humidity,this.condition});

  factory CurrentWeather.fromJson(Map<String,dynamic> jsonB){
    return CurrentWeather(
      temperature: jsonB["temp_c"] as double,
      wind: jsonB["wind_kph"] as double,
      pressure: jsonB["pressure_in"] as double,
      humidity: jsonB ["humidity"] as int,
      condition: Condition.fromJson(jsonB['condition'])
    );
  }
}
class Condition{
  String climate;
  int code;
  Condition({this.climate,this.code});

  factory Condition.fromJson(Map<String,dynamic> json){
    return Condition(
      climate: json["text"] as String,
      code: json["code"] as int
    );
  }
}


class Forecast
{
  List<ForecastDay> forecastDay;

  Forecast({this.forecastDay});

  factory Forecast.fromJson(Map<String,dynamic> jsonG){
    
    var list=jsonG['forecastday'] as List;
    print(list.runtimeType);
    List<ForecastDay> forecastList=list.map((i)=> ForecastDay.fromJson(i)).toList();

    return Forecast(
    forecastDay: forecastList
    );
  }

}


class ForecastDay{
  int time;
  Day day;

  ForecastDay({this.time,this.day});

  factory ForecastDay.fromJson(Map<String,dynamic> jsonC ){
    return ForecastDay(
      time:jsonC['date_epoch'] as int,
      day: Day.fromJson(jsonC['day']),
   );
 }
}

class Day{
  double avgTemp_C;
  double avgTemp_F;
  double maxTemp_C;
  double maxTemp_F;
  forecastCondition condition;

  Day({this.avgTemp_C,this.avgTemp_F,this.maxTemp_C,this.maxTemp_F,this.condition});

  factory Day.fromJson(Map<String,dynamic> jsonE){
    return Day(
      avgTemp_C: jsonE['avgtemp_c'] as double,
      avgTemp_F: jsonE['avgtemp_f'] as double,
      maxTemp_C: jsonE['maxtemp_c'] as double,
      maxTemp_F: jsonE['maxtemp_f'] as double,
      condition:forecastCondition.fromJson(jsonE['condition'])

     );
  }
}

class forecastCondition{
  String text;
  int code;

  forecastCondition({this.text,this.code});

  factory forecastCondition.fromJson(Map<String,dynamic>jsonG){
    return forecastCondition(
      text: jsonG['text'] as String,
      code: jsonG['code'] as int
    );
  }
}
