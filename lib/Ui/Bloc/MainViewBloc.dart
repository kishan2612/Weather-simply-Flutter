import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/Model/MainListRow.dart';

class MainActivityBloc {
  final _dbHelper;

  var _allCitiesWeatherDataList = <MainListRow>[];

  final _citiesWeatherDataSubject = BehaviorSubject<List<MainListRow>>();

  MainActivityBloc(this._dbHelper) {
    _citiesWeatherDataSubject.add(_allCitiesWeatherDataList);
  }

  Stream<List<MainListRow>> get allCitiesWeatherData =>
      _citiesWeatherDataSubject.stream;

  void _listenToCitiesWeatherData() {
    _getCitiesWeatherDatafromDB(_dbHelper).then((it) {
      _citiesWeatherDataSubject.add(_allCitiesWeatherDataList);
    });
  }

  Future<Null> _getCitiesWeatherDatafromDB(_dbHelper) async {
    print("Getcity MainList");
    var cityDetails = _dbHelper.getAllCity();
    _allCitiesWeatherDataList = cityDetails;
  }
}
