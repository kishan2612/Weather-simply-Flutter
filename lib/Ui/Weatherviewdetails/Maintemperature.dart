import 'package:flutter/material.dart';
import 'package:weatherapp/Ui/Provider/WeatherViewProvider.dart';

class MainTemperature extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      var _mainlistData = WeatherViewProvider.of(context).mainListRow;

    return Column(
          children: <Widget>[
        Container(
          child:  new RichText(
            text: new TextSpan(
              text:"${_mainlistData.temperature.round()}\u00b0",
              style: new TextStyle(fontSize: 70.0,color: Colors.black),
              children: <TextSpan>[
                new TextSpan(
                  text: "C",style: new TextStyle(fontSize: 70.0,color: Colors.black54)
                )
              ]
            ),
          ),
        ),

        
        
      ]
    );
  }

}