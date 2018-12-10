import 'package:flutter/material.dart';

import 'package:weatherapp/Model/listrowdata.dart';
import 'package:weatherapp/Model/MainListRow.dart';

class CustomListrow extends StatelessWidget {

  final MainListRow listData;

  CustomListrow(this.listData);
  @override
  Widget build(BuildContext context) {

    return new Container(
      margin: new EdgeInsets.only(top:16.0 ),
      decoration: new BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: new BorderRadius.circular(16.0) 
      ),
          child: new GestureDetector(
            onTap: (){
           // Navigator.of(context).pushNamed('/weatherview');
            },
        child: Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  children: <Widget>[
                    new Text(
                      listData.climate,
                      textScaleFactor: 0.9,
                      textAlign: TextAlign.left,
                    ),
                    new Text(
                      listData.temperature.round().toString(),
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],crossAxisAlignment: CrossAxisAlignment.start),
              ),
              new Expanded(
                child:  new Text(
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
}