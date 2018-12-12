import 'package:flutter/material.dart';
import 'package:weatherapp/Ui/Provider/WeatherViewProvider.dart';
import 'package:weatherapp/Utilities/layoutclipping.dart';
import 'package:weatherapp/Ui/Presenter/WeatherDetailPresenter.dart';

class WeatherImage extends StatefulWidget {

  @override
  _WeatherImageState createState() => _WeatherImageState();
}

class _WeatherImageState extends State<WeatherImage> {
  final _imagePresenter = WeatherDetailPresenter();


  @override
  Widget build(BuildContext context) {
      var _mainlistData = WeatherViewProvider.of(context).mainListRow;

    return Container(
        child: ClipPath(
      clipper: new Toplayer(),
      child: new Container(
        alignment: Alignment.topLeft,
        padding: new EdgeInsets.all(16.0),
        width: double.infinity,
        color: Colors.amber[300],
        child: new Column(
          children: <Widget>[
            Center(
                child: new Text(
              "Monday 25th",
              style: new TextStyle(fontSize: 18.0),
            )),
            Center(
              child: Container(
                padding: EdgeInsets.all(25.0),
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 120.0,
                  child: _imagePresenter.checkWeatherCode(_mainlistData.code),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
