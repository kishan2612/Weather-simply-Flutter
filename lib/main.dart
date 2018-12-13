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
        title: "Weather Simply",
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
            "Weather Simply",
            style:
                new TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.amber,
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

  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  // List<MainListRow> weatherRow;

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

  @override
  Widget build(BuildContext context) {
    if (_lifecycleState == AppLifecycleState.resumed) {
      print("Lifecycle state $_lifecycleState");

      if (_mainUiBloc != null) {
        _mainUiBloc.listenToCitiesWeatherData();
      }
    }
    return RefreshIndicator(
      key: _refreshKey,
      onRefresh: _onRefresh,
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
                  child: Text("No data available",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  ),),
                ),
              );
            } else {
              return _mainListViewBuilder(snapshot.data);
            }
          },
        ),
      ),
    );
  }

  Widget _mainListViewBuilder(List<MainListRow> data) {
    return new ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        final item = data[index].city;
        return new Column(
          children: <Widget>[
            Container(
              child: new Dismissible(
                key: Key(item),
                direction: DismissDirection.endToStart,
                background: dissmissbackground,
                onDismissed: (direction) {
                  _mainUiBloc
                      .deleteSwipedRowfromDB(data[index].cityId, index)
                      .then((onValue) {
                    print("Deleted successfully");
                  });
                },
                child: _customListRow(data[index]),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _customListRow(MainListRow listData) {
    return GestureDetector(
      onTap: () {
        _openWeatherView(context, listData);
      },
      child: new Container(
        margin: new EdgeInsets.only(top: 16.0),
        decoration: new BoxDecoration(
            color: Colors.amber[300], borderRadius: new BorderRadius.circular(16.0)),
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

  Future<void> _onRefresh() async {
    print("OnRefresh");
    await Future.delayed(const Duration(seconds: 3), () async {
      _mainUiBloc.onRefreshPulled().then((resultBoolean) {
        print("result boolean $resultBoolean");
        if (resultBoolean) {
          print("Successfully updated data");
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Updated successfully"),
          ));
        }
      });
    });
  }

  _openWeatherView(BuildContext context, MainListRow listData) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeatherView(mainListRow: listData)));
  }
}
