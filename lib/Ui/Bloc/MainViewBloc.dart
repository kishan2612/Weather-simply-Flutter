import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/Model/MainListRow.dart';
import 'package:weatherapp/Repository/Database/DatabaseHelper.dart';

class MainActivityBloc {
  final _dbHelper = DatabaseHelper();

  List<MainListRow> _allCitiesWeatherDataList =[];

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

bool deleteSwipedRowfromDB(int cityId, int listIndex){
  print("Delete fuc");
    Future<int> _response = _dbHelper.deleteRow(cityId);
    _response.then((response){
      if(response>0) {
        _deleteRowfromList(listIndex);
        return true;
      }
    });

    return false;
}

void _deleteRowfromList(int listIndex){
  _allCitiesWeatherDataList.removeAt(listIndex);
}


  Future<Null> _getCitiesWeatherDatafromDB(_dbHelper) async {
    print("Getcity MainList");
    List<MainListRow> cityDetails =await _dbHelper.getAllCity();
    
        _allCitiesWeatherDataList = cityDetails;

if(_allCitiesWeatherDataList.isNotEmpty){
   _allCitiesWeatherDataList.forEach((it)=> print("___ "+it.city));
  }}
}
