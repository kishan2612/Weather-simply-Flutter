import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/Model/MainListRow.dart';
import 'package:weatherapp/Model/UpdateCities.dart';
import 'package:weatherapp/Repository/Database/DatabaseHelper.dart';
import 'package:weatherapp/Repository/Network/CallAndParse.dart';

class MainActivityBloc {

  final _dbHelper = DatabaseHelper();

  List<MainListRow> _allCitiesWeatherDataList = [];

  final _citiesWeatherDataSubject = BehaviorSubject<List<MainListRow>>();

  MainActivityBloc() {
    _citiesWeatherDataSubject.add(_allCitiesWeatherDataList);
    listenToCitiesWeatherData();
  }

  Stream<List<MainListRow>> get allCitiesWeatherData =>
      _citiesWeatherDataSubject.stream;

  void listenToCitiesWeatherData() {
    print("Getting database ");
    _getCitiesWeatherDatafromDB(_dbHelper).then((it) {
      _citiesWeatherDataSubject.add(_allCitiesWeatherDataList);
    });
  }

  Future<bool> deleteSwipedRowfromDB(int cityId, int listIndex) async {
    print("Delete fuc");
    var _response = await _dbHelper.deleteRow(cityId);
    if (_response > 0) {
      _deleteRowfromList(listIndex);
      return true;
    }
    return false;
  }

  void _deleteRowfromList(int listIndex) {
    _allCitiesWeatherDataList.removeAt(listIndex);
    _citiesWeatherDataSubject.add(_allCitiesWeatherDataList);
  }

  Future<Null> _getCitiesWeatherDatafromDB(_dbHelper) async {
    print("Getcity MainList");
    List<MainListRow> cityDetails = await _dbHelper.getAllCity();

    _allCitiesWeatherDataList = cityDetails;

    if (_allCitiesWeatherDataList.isNotEmpty) {
      _allCitiesWeatherDataList.forEach((it) => print("___ " + it.city));
    }
  }

  Future<bool> onRefreshPulled() async {
    var _updateResponse = await checkAndUpdateDB();
    print("onRefreshpulled : $_updateResponse");
    if (_updateResponse) {
      print("_updateresponse $_updateResponse");
      listenToCitiesWeatherData();
    }
    return _updateResponse;
  }

  Future<bool> checkAndUpdateDB() async {
    var response = false;
    var _dbDataCount = await _dbHelper.checkDBHasData();
    if (_dbDataCount > 0) {
      print("Yes it has data");
      List<UpdateCity> _cityListFromDB =
          await _dbHelper.getAllCityNamesfromDB();
      print("check and update db " + _cityListFromDB.toString());
      await fetchAndUpdateDB(_cityListFromDB).then((count) {
        print("Count $count");
        if (count == _dbDataCount) {
          response = true;
        }else{

        }
      });
    } else {}

    return response;
  }

  Future<int> fetchAndUpdateDB(List<UpdateCity> cityListFromDB) async {
    int count = 0;

    for (int i = 0; i < cityListFromDB.length; i++) {
      print("fetch and update DB ${cityListFromDB[i].cityName}");

      await fetchOldData(cityListFromDB[i].cityName, cityListFromDB[i].cityId);
      count++;
    }
    return count;
  }
}
