import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/Model/MainListRow.dart';
import 'package:weatherapp/Repository/Database/DatabaseHelper.dart';

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

  void onRefreshPulled(){
    
  }
}
