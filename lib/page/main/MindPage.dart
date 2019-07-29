import 'package:flutter/material.dart';

class MindPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new Scaffold(
        appBar: new AppBar(
          title: new Text("我的"),
          backgroundColor: Colors.green,
        ),
        body: new Center(
          child: new Text("我的"),
        ),
    );
  }
}