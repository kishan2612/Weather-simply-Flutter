

import 'package:flutter/material.dart';
import 'package:weatherapp/Model/MainListRow.dart';

class WeatherViewProvider extends InheritedWidget{
final MainListRow mainListRow;
final Widget child;
  WeatherViewProvider({this.mainListRow, this.child}) : super(child:child);

  static WeatherViewProvider of(BuildContext context) =>
  context.inheritFromWidgetOfExactType(WeatherViewProvider);
  
  @override
  bool updateShouldNotify(WeatherViewProvider oldWidget) {
    return mainListRow != oldWidget.mainListRow;
  }
  
}