import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:weatherapp/Model/SearchResult.dart';
import 'package:weatherapp/Repository/Network/CallAndParse.dart';
import 'package:weatherapp/Utilities/SampleSearchData.dart';
import 'package:weatherapp/Ui/Bloc/SearchViewBloc.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>{
    final _searchBloc = SearchActivityBloc();

  TextEditingController _textEditingController;

  String _listViewHeader = "RECOMMENDED CITIES";
/*
Fill with dummy city name and url query at startup
*/
  List<SearchList> _searchList = [
    SampleSearchData.getChennai(),
    SampleSearchData.getDelhi(),
    SampleSearchData.getKolkata(),
    SampleSearchData.getMumbai()
  ];

  @override
  void initState() {
    super.initState();
    _textEditingController = new TextEditingController();

    print("Search init state");
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();

    print("Search dispose state");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.amber,
        title: Theme(
          data: ThemeData(
            primaryColor: Colors.black,
          ),
          child: new TextField(
            textInputAction: TextInputAction.go,
            style: TextStyle(color: Colors.black,fontSize: 18),
            controller: _textEditingController,
            cursorColor: Colors.black,

            //onsubmitted is executed on clicknin henter/go option in keyboard
            onSubmitted: ((query) {
              print("Submit query");

              _searchBloc.searchForCity(query);
            }),
            decoration: InputDecoration(
              hintText: "Search city",
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              if (_textEditingController.text.length > 0) {
                _textEditingController.clear();
              }
            },
          )
        ],
      ),
      body: StreamBuilder<List<SearchList>>(
          stream:_searchBloc.queryResult,
          initialData: [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              child: _searchListBuilder(snapshot.data),
            );
          }),
    );
  }

  Widget _searchListBuilder(List<SearchList> searchList) {
    print("listlength ${searchList.length}");
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return new ListTile(
          title: Text(searchList.elementAt(index).region),
          leading: Icon(Icons.location_city),
          onTap: (){
            print(searchList.elementAt(index).region);
            var _response = _searchBloc.fetchCityDataAndReturnResponse(searchList.elementAt(index).url);
            _response.then((response){
            if(response){
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Data received successfully"),
                )
              );
            }else{
               Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("An error occurred"),
                ));
            }
          });
          }
        );
      },
      itemCount: searchList.length,
    );
  }
}
