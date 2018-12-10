import 'package:weatherapp/Model/SearchResult.dart';
import 'package:weatherapp/Repository/Network/CallAndParse.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/Utilities/SampleSearchData.dart';

class SearchActivityBloc {
  var _searchList = <SearchList>[
    SampleSearchData.getChennai(),
    SampleSearchData.getDelhi(),
    SampleSearchData.getKolkata(),
    SampleSearchData.getMumbai()
  ];
  final _searchResultSubject = BehaviorSubject<List<SearchList>>();

  SearchActivityBloc() {
    print("Bloc constructor");
    _searchResultSubject.add(_searchList);
  }

  Stream<List<SearchList>> get queryResult => _searchResultSubject.stream;

  void searchForCity(String query) {
    print("On click");
    _getSearchQueryList(query).then((_) {
      print("Bloc " + _searchList.length.toString());
      _searchResultSubject.add(_searchList);
    });
  }

  Future<Null> _getSearchQueryList(String query) async {
    final searchlist = await fetchSearchQuery(query);
    print(searchlist.runtimeType);
    _searchList = searchlist;

    _searchList.forEach((it) => print("value " + it.region));
  }

  Future<bool> fetchCityDataAndReturnResponse(String query) {
    Future<bool> _response = fetchData(query);
    
    return _response;
  }
}
