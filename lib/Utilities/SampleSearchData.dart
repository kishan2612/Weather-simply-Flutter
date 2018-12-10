
import 'package:weatherapp/Model/SearchResult.dart';

class SampleSearchData{

  static SearchList getDelhi(){
    return new SearchList(region: "Delhi",url: "Delhi");
  }

   static SearchList getMumbai(){
    return new SearchList(region: "Mumbai",url: "Mumbai");
  }

   static SearchList getChennai(){
    return new SearchList(region: "Chennai",url: "Chennai");
  }

   static SearchList getKolkata(){
    return new SearchList(region: "Kolkata",url: "Kolkata");
  }
}