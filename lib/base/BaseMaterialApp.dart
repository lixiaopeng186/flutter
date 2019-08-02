import 'package:flutter/material.dart';


typedef Widget Home();

class BaseMaterilApp extends StatefulWidget{
  Color primaryColor;
  Home home;
  BaseMaterilApp(
      this.home,
      {Key key,
    this.primaryColor = Colors.blue,

  }) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _BaseMaterilState();
  }

}

class _BaseMaterilState extends State<BaseMaterilApp>{
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: widget.primaryColor
      ),
//      home: widget.home ,
    );
  }
}