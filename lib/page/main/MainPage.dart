import 'package:flutter/material.dart';

class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("首页"),
      ),
      body: new Column(
        children: <Widget>[
          new FlatButton(onPressed: (){

          }, child: new Text("点击看看"))
        ],
      ),
      floatingActionButton: new Builder(builder: (BuildContext context){
        return new FloatingActionButton(
            onPressed: (){
              print("点击-floatingActionButton");
            },
            tooltip: "请点击看看",
            foregroundColor: Colors.white,//前景色
            backgroundColor: Colors.blue,//背景色
            elevation: 5.0,//阴影值
            highlightElevation: 10.0,//点击阴影值
            shape: new CircleBorder(),//圆形边
            child: new Icon(Icons.add),//设置图片
        );
      }),
    );
  }
}