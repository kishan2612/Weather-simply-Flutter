import 'dart:async';

import 'package:flutter/material.dart';
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
          '/searchview': (BuildContext context) => new SearchView(),
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

class _MainBodyState extends State<MainBody> with WidgetsBindingObserver {
  var _mainUiBloc = MainActivityBloc();

  var _refreshKey = GlobalKey<RefreshIndicatorState>();

  List<MainListRow> weatherRow;

  AppLifecycleState _lifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    print("Init state");
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);

    print("dispose state");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lifecycleState = state;
      print("State $state");
    });
  }

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

  @override
  Widget build(BuildContext context) {
    if(_lifecycleState == AppLifecycleState.resumed){
          print("Lifecycle state ${_lifecycleState}");

      if(_mainUiBloc != null){
        _mainUiBloc.listenToCitiesWeatherData();
      }
    }
    return RefreshIndicator(
      key: _refreshKey,
      onRefresh: () {},
      child: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: StreamBuilder<List<MainListRow>>(
          stream: _mainUiBloc.allCitiesWeatherData,
          initialData: [],
          builder: (context, snapshot) {
            print("Main Snapshot ${snapshot.data.length}");
            if (snapshot.data.isEmpty) {
              return Center(
                child: Container(
                  child: Text("Empty"),
                ),
              );
            } else {
              weatherRow = snapshot.data;

              return _mainListViewBuilder();
            }
          },
        ),
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
                  _mainUiBloc.deleteSwipedRowfromDB(
                      weatherRow[index].cityId, index);
                },
                child: new GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WeatherView(mainListRow: weatherRow[index])));
                    },
                    child: _customListRow(weatherRow[index])),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _customListRow(MainListRow listData) {
    return new Container(
      margin: new EdgeInsets.only(top: 16.0),
      decoration: new BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: new BorderRadius.circular(16.0)),
      child: new GestureDetector(
        onTap: () {
          // Navigator.of(context).pushNamed('/weatherview');
        },
        child: Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(children: <Widget>[
                  new Text(
                    listData.climate,
                    textScaleFactor: 0.9,
                    textAlign: TextAlign.left,
                  ),
                  new Text(
                    listData.temperature.round().toString(),
                    textScaleFactor: 1.5,
                    textAlign: TextAlign.left,
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  )
                ], crossAxisAlignment: CrossAxisAlignment.start),
              ),
              new Expanded(
                child: new Text(
                  listData.city,
                  textScaleFactor: 2.0,
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
      ),
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
