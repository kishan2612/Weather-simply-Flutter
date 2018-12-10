class SearchResult {
  List<SearchList> searchlist;

  SearchResult({this.searchlist});

  factory SearchResult.fromJson(List<dynamic> json){
    List<SearchList> _list = new List<SearchList>();
    _list = json.map((i) => SearchList.fromJson(i)).toList();
    return new SearchResult(
      searchlist: _list
    );
  }
}

class SearchList {
 final String region;
 final String url;

  SearchList({this.region, this.url});

  factory SearchList.fromJson(Map<String, dynamic> resultJSON) {
    return new SearchList(
        region: resultJSON['name'] as String,
         url: resultJSON['url'] as String);
  }

  get all => region + "\t" + url;
}
