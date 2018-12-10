import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:weatherapp/Model/SearchResult.dart';
import 'package:weatherapp/Repository/Network/CallAndParse.dart';
import 'package:weatherapp/Utilities/SampleSearchData.dart';
import 'package:weatherapp/Ui/Bloc/SearchViewBloc.dart';

class SearchView extends StatefulWidget {
  final _searchBloc = SearchActivityBloc();
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: Theme(
          data: ThemeData(
            primaryColor: Colors.black,
          ),
          child: new TextField(
            textInputAction: TextInputAction.go,
            style: TextStyle(color: Colors.black),
            controller: _textEditingController,
            cursorColor: Colors.black,

            //onsubmitted is executed on clicknin henter/go option in keyboard
            onSubmitted: ((query) {
              print("Submit query");

              widget._searchBloc.searchForCity(query);
              // Future<List<SearchList>> _searchQueryList =
              //     fetchSearchQuery(query);
              // _searchQueryList.then((result) {
              //   setState(() {
              //     _searchList = result;
              //   });
              // });
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
        stream: widget._searchBloc.queryResult,
        initialData: [],
        builder: (BuildContext context ,AsyncSnapshot snapshot) 
        {

          switch(snapshot.connectionState){

            case ConnectionState.done:

            case ConnectionState.active:return Container(
          child: _searchListBuilder(snapshot.data), );

            case ConnectionState.waiting:return Center(child: CircularProgressIndicator());

            case ConnectionState.none: 

            default : 

          }
        }
        
      ),
    );
  }

  Widget _searchListBuilder(List<SearchList> searchList) {
    print("listlength ${searchList.length}");
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return new ListTile(
          title: Text(searchList.elementAt(index).region),
          leading: Icon(Icons.location_city),
/*
        onTap the listview item fetch the required city weather details and store in DB.
        */
          // onTap: () {
          //   print(searchList.elementAt(index).url);
          //   var response = fetchData(searchList.elementAt(index).url);
          //   response.then((onValue) {
          //     if (onValue) {
          //       Scaffold.of(context).showSnackBar(
          //           new SnackBar(content: Text("Data received Successfully")));
          //     } else {
          //       Scaffold.of(context).showSnackBar(
          //           new SnackBar(content: Text("An error occurred")));
          //     }
          //   });
          // },
        );
      },
      itemCount: searchList.length,
    );
  }
}
