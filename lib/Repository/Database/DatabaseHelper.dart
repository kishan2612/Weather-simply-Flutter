import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weatherapp/Model/WeatherModel.dart';
import 'package:weatherapp/Model/MainListRow.dart';
import 'package:weatherapp/Model/UpdateCities.dart';

class DatabaseHelper {
  final String tableName="Place";
  final String rowId="id";
  static final DatabaseHelper _dbHelper=new DatabaseHelper.internal();

  DatabaseHelper.internal();
  factory DatabaseHelper() => _dbHelper;

  static Database _database;

  Future<Database> get database async{

    if(_database!=null){
      return _database;
    }
    _database=await initdatabase();
        return _database;
 }
    
 initdatabase() async {
     
     var databasePath=await getDatabasesPath();
     String path= join(databasePath,"weather.db");

     var ourDatabase= await openDatabase(path,version: 1,
      onCreate:_oncreate);
                  return ourDatabase; 
              
 }
            
           
 void _oncreate(Database db, int version) async{
   await db.execute("CREATE TABLE Place(id INTEGER PRIMARY KEY AUTOINCREMENT,city TEXT, country TEXT, time TEXT, temp REAL, wind REAL, pressure REAL, humidity INTEGER, climate TEXT, climateCode INTEGER"+
  ", dayoneTime INTEGER, dayoneTemp REAL, dayoneClimate INTEGER, daytwoTime INTEGER, daytwoTemp REAL, daytwoClimate INTEGER, daythreeTime INTEGER, daythreeTemp REAL, daythreeClimate INTEGER)");
    print("Table is created");
}

Future<int> saveCity(CurrentWeatherModel model )async {
  var dbClient= await database;
  //raw insert without map
  int response=await dbClient.rawInsert("INSERT INTO Place(city,country,time,temp,wind,pressure,humidity,climate,climateCode,dayoneTime,dayoneTemp,dayoneClimate,daytwoTime,daytwoTemp,daytwoClimate,daythreeTime,daythreeTemp,daythreeClimate)" 
 +" VALUES(\"${model.location.city}\",\"${model.location.country}\",\"${model.location.time}\","
 +"${model.currentWeather.temperature},${model.currentWeather.wind},${model.currentWeather.pressure},${model.currentWeather.humidity},\"${model.currentWeather.condition.climate}\",${model.currentWeather.condition.code},"
 +"${model.forecast.forecastDay[1].time},${model.forecast.forecastDay[1].day.avgTemp_C},${model.forecast.forecastDay[1].day.condition.code},"
 +"${model.forecast.forecastDay[2].time},${model.forecast.forecastDay[2].day.avgTemp_C},${model.forecast.forecastDay[2].day.condition.code},"
  +"${model.forecast.forecastDay[3].time},${model.forecast.forecastDay[3].day.avgTemp_C},${model.forecast.forecastDay[3].day.condition.code}"
  +")");
  return response;
}

Future<List<MainListRow>>getAllCity()async{
var dbClient=await database;
List <Map> list= await dbClient.rawQuery("SELECT id,city,temp,climate,climateCode,wind,pressure,humidity,dayoneTime,dayoneTemp,dayoneClimate,daytwoTime,daytwoTemp,daytwoClimate,daythreeTime,daythreeTemp,daythreeClimate FROM Place");
List<MainListRow> weather=new List();
print(list.length);
for(int i=0;i<list.length;i++){
  weather.add(new MainListRow(list[i]["id"],list[i]["city"],list[i]["temp"],list[i]["climate"],list[i]["climateCode"],list[i]["wind"],list[i]["pressure"],list[i]["humidity"],
  list[i]["dayoneTime"],list[i]["dayoneTemp"],list[i]["dayoneClimate"],
  list[i]["daytwoTime"],list[i]["daytwoTemp"],list[i]["daytwoClimate"],
  list[i]["daythreeTime"],list[i]["daythreeTemp"],list[i]["daythreeClimate"]));
}
return weather;
}

Future<int> updateWeatherData(CurrentWeatherModel model,int _id) async{

  var _dbclient=await database;
  int response=await _dbclient.update("Place", model.toMap(),where:"id=$_id");
    print("save updated data response "+response.toString());
  return response;


}

Future<int> deleteRow(int cityId)async{
  var _dbClient=await database;
  int _response=await _dbClient.delete(tableName,where:"$rowId=?",whereArgs: [cityId]);
  print("deleterow "+_response.toString());
  return _response;

}

Future<bool> checkDBHasData()async{
  if(await getCount()>0){
    return true;
  }
  return false;
}

Future<List<UpdateCity>> getAllCityNamesfromDB() async{
  var dbClient=await database;
  List<UpdateCity> updateCityList=new List();
  List<Map> updatecityMap=await dbClient.rawQuery("SELECT id,city FROM Place");
  for(int i=0;i<updatecityMap.length;i++){
    updateCityList.add(new UpdateCity(updatecityMap[i]["id"],updatecityMap[i]["city"]));
  }
  print("Update City Map "+updatecityMap.toString());
  return updateCityList;
}

 Future<int> getCount()async {
  var dbClient=await database;
  int count=Sqflite.firstIntValue( await dbClient.rawQuery("SELECT COUNT(*) FROM Place"));
  return count;
}
}