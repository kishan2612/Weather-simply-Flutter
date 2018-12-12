import 'package:flutter/material.dart';
import 'package:weatherapp/Ui/Provider/WeatherViewProvider.dart';
import 'Maintemperature.dart';
import 'Extraweatherdetails.dart';
import 'package:weatherapp/Model/MainListRow.dart';
import 'WeatherImage.dart';
import 'package:weatherapp/Utilities/CommUtill.dart';
import 'package:weatherapp/Ui/Presenter/WeatherDetailPresenter.dart';

class WeatherView extends StatefulWidget {
  final MainListRow mainListRow;
  WeatherView({Key key, this.mainListRow}) : super(key: key);

  @override
  _WeatherViewState createState() => _WeatherViewState(mainListRow);
}

class _WeatherViewState extends State<WeatherView> {
  final MainListRow mainListRow;

  final _weatherPresenter = WeatherDetailPresenter();
  final _scaffoldkey = new GlobalKey<ScaffoldState>();
  VoidCallback _showBottomsheetCallback;

  _WeatherViewState(this.mainListRow);

  @override
  void initState() {
    super.initState();
    _showBottomsheetCallback = _showbottomSheet;
  }

  void _showbottomSheet() {
    MainListRow weatherData = mainListRow;
    setState(() {
      _showBottomsheetCallback = null;
    });
    _scaffoldkey.currentState
        .showBottomSheet<void>((BuildContext context) {
          return new Container(
            height: 250.0,
            width: double.infinity,
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius:
                    new BorderRadius.vertical(top: Radius.circular(32.0))),
            child: new Column(
              children: <Widget>[
                new Container(
                    height: 30.0,
                    child: new IconButton(
                        icon: new Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(_scaffoldkey.currentContext);
                        })),
                new Container(
                  height: 60.0,
                  child: _bottomsheetRows(weatherData.dayOneTime,
                      weatherData.dayOneClimate, weatherData.dayOneTemp),
                ),
                new Container(
                  height: 60.0,
                  child: _bottomsheetRows(weatherData.dayTwoTime,
                      weatherData.dayTwoClimate, weatherData.dayTwoTemp),
                ),
                new Container(
                  height: 60.0,
                  child: _bottomsheetRows(weatherData.dayThreeTime,
                      weatherData.dayThreeClimate, weatherData.dayThreeTemp),
                ),
              ],
            ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showBottomsheetCallback = _showbottomSheet;
            });
          }
        });
  }

  _bottomsheetRows(int time, int climate, double temperature) {
    print("upcoming $climate");
    var newRow = new Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Center(
            child: new Text(
              CommUtill.timestampToDate(time),
              style: new TextStyle(color: Colors.black),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: new SizedBox(
            width: 25,
            height: 25,
            child: _weatherPresenter.checkWeatherCode(climate),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: new Text(temperature.round().toString() + "\u00b0C",
                style: new TextStyle(color: Colors.black)),
          ),
        )
      ],
    );

    return newRow;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherViewProvider(
        mainListRow: mainListRow,
        child: new Scaffold(
          key: _scaffoldkey,
          appBar: new AppBar(
            title: new Text(
              mainListRow.city,
              style: new TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.amber,
            leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).maybePop();
              },
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Column(children: <Widget>[
              new Expanded(flex: 4, child: WeatherImage()),
              new Expanded(flex: 1, child: MainTemperature()),
              new Expanded(flex: 2, child: ExtraDetails()),
              new FloatingActionButton.extended(
                backgroundColor: Colors.amber[300],
                label: Text(
                  "Upcoming forecast",
                  style: new TextStyle(color: Colors.black),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.black,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(const Radius.circular(16.0))),
                onPressed: _showBottomsheetCallback,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
