import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weatherapp/Model/UpdateCities.dart';
import 'package:weatherapp/Repository/Database/DatabaseHelper.dart';
import 'package:weatherapp/Repository/Network/CallAndParse.dart';
import 'package:weatherapp/Ui/CustomlistView.dart';
import 'package:weatherapp/Ui/Weatherviewdetails/Weatherview.dart';
import 'package:weatherapp/Model/MainListRow.dart';
import 'package:weatherapp/Ui/Bloc/MainViewBloc.dart';
import "Ui/SearchView.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(backgroundColor: Colors.white, fontFamily: 'Sans'),
        home: new MyHomepage(),
        routes: <String, WidgetBuilder>{
          '/searchview' : (BuildContext context) => new SearchView(),
        });
  }
}

class MyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "WEATHER",
            style:
                new TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/searchview');
          },
          backgroundColor: Colors.black,
          child: new Icon(Icons.add),
        ),
        body: MainBody());
  }
}

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  final _mainUiBloc = MainActivityBloc();

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  var weatherRow;

  // Future<Null> _onRefreshPulled() async {
  //   Completer<Null> completer = new Completer<Null>();
  //   Future<bool> _isDBHasData = _dbHelper.checkDBHasData();
  //   _isDBHasData.then((onValue) {
  //     if (onValue) {
  //       print("Yes DB has data");
  //       Future<List<UpdateCity>> updateCitylist =
  //           _dbHelper.getAllCityNamesfromDB();

  //       updateCitylist.then((citylist) {
  //         citylist.forEach((it) {
  //           fetchOldData(it.cityName, it.cityId);
  //         });
  //         setState(() {
  //           _getCityFromDB(_dbHelper).then((value) {
  //             setState(() {
  //               weatherRow = value;
  //             });
  //           });
  //         });
  //       });
  //     }
  //   });
  //   new Future.delayed(new Duration(seconds: 2)).then((_) {
  //     completer.complete();
  //   });
  //   return completer.future;
  // }

  void deleteSwipeRow(_dbHelper, int id, context, int index) {
    print("Delete fuc");
    Future<int> response = _dbHelper.deleteRow(id);
    response.then((resp) {
      if (resp > 0) {
        print("Index to delete $index");
        _deleteCityfromList(index);
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Deleted"),
        ));
      }
    });
  }

  _deleteCityfromList(int index) {
    setState(() {
      weatherRow.removeAt(index);
    });
  }

  Future<List<MainListRow>> _getCityFromDB(_dbHelper) async {
    print("Getcity MainList");
    Future<List<MainListRow>> cityDetails = _dbHelper.getAllCity();

    return cityDetails;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: (){},
      child: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: StreamBuilder(
          initialData: [],
          stream: _mainUiBloc.allCitiesWeatherData,
          builder: (context,snapshot){
             if (snapshot.hasError) {
                return Text("Error:  ${snapshot.error}");
              }else{
                weatherRow = snapshot.data;

                return _mainListViewBuilder();
              }
            
          },
        ),
        // child: new FutureBuilder(
        //     future: _getCityFromDB(_dbHelper),
        //     builder: (BuildContext context, AsyncSnapshot snapshot) {
        //       switch (snapshot.connectionState) {
        //         case ConnectionState.none:

        //         case ConnectionState.waiting:
        //           return new CircularProgressIndicator();
        //         default:
        //           if (snapshot.hasError)
        //             return new Text('Error: ${snapshot.error}');
        //           else
        //             weatherRow = snapshot.data;
        //           return _mainListViewBuilder();
        //       }
        //     }),
      ),
    );
  }

  Widget _mainListViewBuilder() {
    return new ListView.builder(
      itemCount: weatherRow.length,
      itemBuilder: (BuildContext context, int index) {
        final item = weatherRow[index].toString();
        return new Column(
          children: <Widget>[
            Container(
              child: new Dismissible(
                key: Key(item),
                direction: DismissDirection.endToStart,
                background: dissmissbackground,
                onDismissed: (direction) {
                  // deleteSwipeRow(
                  //     _dbHelper, weatherRow[index].cityId, context, index);
                },
                child: new GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WeatherView(mainListRow: weatherRow[index])));
                      //  Navigator.of(context).pushNamed('/weatherview');
                    },
                    child: new CustomListrow(weatherRow[index])),
              ),
            ),
          ],
        );
      },
    );
  }

  var dissmissbackground = Container(
      margin: new EdgeInsets.only(top: 16.0),
      child: new Align(
        alignment: Alignment.centerRight,
        child: new Text(
          "Delete",
          style: new TextStyle(color: Colors.red, fontSize: 24.0),
        ),
      ));
}
