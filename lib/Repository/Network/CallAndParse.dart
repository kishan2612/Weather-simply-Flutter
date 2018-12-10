import 'dart:async';
import 'dart:convert';
import 'package:weatherapp/Repository/Database/DatabaseHelper.dart';
import 'package:weatherapp/Utilities/GlobalConstants.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/Model/WeatherModel.dart';
import 'package:weatherapp/Model/SearchResult.dart';


 Future<bool> fetchData(String city) async {
  var url = GlobalConstants.forecastUrl + city + "&days=4";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    parseData(response.body);
    return true;
  } else {
    return false;
  }
}

Future<bool> fetchOldData(String city, int id) async {
  var _url = GlobalConstants.forecastUrl + city + "&days=4";
  var response = await http.get(_url);
  if (response.statusCode == 200) {
    print(response.body);
    parseUpdatedWeatherData(id, response.body);
    return true;
  } else {
    return false;
  }
}

Future<List<SearchList>> fetchSearchQuery(String query) async {
  var _queryUrl = GlobalConstants.searchCityurl + query;
  var _searchResponse = await http.get(_queryUrl);
  if (_searchResponse.statusCode == 200) {
    print("HTTP response \t"+_searchResponse.body);
    SearchResult _searchResultList = parseSearchQuery(_searchResponse.body);

    return _searchResultList.searchlist.toList();
  }
  }

SearchResult parseSearchQuery(String body) {
  final _parseQuery = json.decode(body);
  print("map \t"+_parseQuery.toString());
  SearchResult _searchResult = SearchResult.fromJson(_parseQuery);

  return _searchResult;
  
}

void parseUpdatedWeatherData(int id, String body) {
  final parse = json.decode(body) as Map<String, dynamic>;
  CurrentWeatherModel model = CurrentWeatherModel.fromJson(parse);
  var _dbHelper = DatabaseHelper();
  var response = _dbHelper.updateWeatherData(model, id);
}

void parseData(String body) {
  print(body);
  final parse = json.decode(body) as Map<String, dynamic>;
  CurrentWeatherModel model = CurrentWeatherModel.fromJson(parse);

  var _dbHelper = DatabaseHelper();
  var response = _dbHelper.saveCity(model);
  print(response);
  print(model.location.country + "\t" + model.location.time);
}
