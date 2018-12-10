import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/Repository/Network/CallAndParse.dart';


class Addcity extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: (){
              Navigator.of(context).maybePop();
            },
          ),
          backgroundColor: Colors.white,
          title:  new Text(
            "Add Place",
            style: new TextStyle(
              color: Colors.black
            ),
          ),
        ),
    
       body:  SearchCity()
      ),
    );
  }
}

class SearchCity extends StatefulWidget {
  @override
  _SearchCityState createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  final textcontroller=new TextEditingController();

  @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      textcontroller.dispose();
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
         children: <Widget>[
        Container(
        margin: new EdgeInsets.all(
        16.0
        ),
        child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextField(
              controller: textcontroller,
              decoration: new InputDecoration(
                labelText: "Enter City or Zipcode",
                hintStyle: new TextStyle(
                  color: Colors.black.withAlpha(80),
                ),
              ),
            ),
        ),
      ),
      new RaisedButton(
      color: Colors.black,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.all(Radius.circular(8.0))
      ),
      elevation: 8.0,
      child: new Text("Add"),
      onPressed: (){
      var text=textcontroller.text;
      print(text);
      var response=fetchData(text);
      response.then((onValue){
        if(onValue){
        Scaffold.of(context).showSnackBar(new SnackBar(content:Text("Success")));
        }else{
         Scaffold.of(context).showSnackBar(new SnackBar(content:Text("Failed")));

        }
            });
    
      },        
        )
    ],
       ),
    );
  }
}
