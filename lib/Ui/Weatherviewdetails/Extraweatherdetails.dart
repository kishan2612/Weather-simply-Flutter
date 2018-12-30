import 'package:flutter/material.dart';
import 'package:weatherapp/Ui/Provider/WeatherViewProvider.dart';
import 'package:weatherapp/Utilities/extraicons_icons.dart';




class ExtraDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

          var _mainlistData = WeatherViewProvider.of(context).mainListRow;

    return Container(

      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Container(
            child:_extacoulum(Extraicons.pressureSvg,"Pressure","${_mainlistData.pressure}"),
          ),
          new Container(
           
            child:_extacoulum(Extraicons.humiditySvg,"Humidity","${_mainlistData.humidity}"),
          ),
          new Container(
            
            child:_extacoulum(Extraicons.wingSvg,"Wind","${_mainlistData.wind}"+" m/s"),
          )
        ],
      ),
      
    );
  }
   _extacoulum(Widget icons,String title,String value){

  var extracolumn=new Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(
        child: icons),
      new Text(title),
      new Text(value)
    ],
  );
    return extracolumn;

  }
}