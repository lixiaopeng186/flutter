import 'package:flutter/material.dart';
import 'package:flutter_app_test/common/CommonUtil.dart';

class MainHorizontalPage  extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HorizontalState();
  }
}

class _HorizontalState extends State<MainHorizontalPage>{
  List<HorizontalPageModel> datas;
  @override
  void initState() {
    // TODO: implement initState
    datas = new List();
    _initData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 100,
        child: new ListView.builder(
          shrinkWrap: false,
            itemCount: datas == null ? 0 : datas.length,
            itemBuilder: _OnItemBuilder,
            scrollDirection: Axis.horizontal,
        ),
    );
  }

  Widget _OnItemBuilder(BuildContext context,int position){
    return new _ItemView(datas[position]);
  }
  //子view
  //添加数据
  void _initData(){
    for(int i=0;i<10;i++){
      HorizontalPageModel model = new HorizontalPageModel(i, "$i.055", "35.6$i", "3$i.3", "USDT$i");
      datas.add(model);
    }
    setState(() {
    });
  }
}

//横向滑动的viwe ，每个屏幕展示3个，所以宽度是屏幕的1/3
class _ItemView extends StatefulWidget{
  HorizontalPageModel data;
  _ItemView(this.data);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ItemState();
  }
}

class _ItemState extends State<_ItemView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      width: CommonUtil.getScreenWidth(context) / 3 ,
      child: new Column(
        children: <Widget>[
          _getTextName(),
          _getTextVolue(),
          _getTextRadio(),
          _getTextMoney()
        ],
      ),
    );
  }

  //第一行text
  Widget _getTextName() {
   return new Align(
      alignment: Alignment.center,
      child: new Text(
        widget.data.money,
        style: new TextStyle(
            fontSize: 20,
            color: Colors.black
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,//显示省略号
        softWrap: false,//是否自动换行，false 是不可以截断换行

      ),
    );
  }

  //第二行text
  Widget _getTextVolue(){
    return new Container(
      alignment: Alignment.center,
      margin: new EdgeInsets.only(top: 5),
      child: new Text(
        widget.data.value,
        style: new TextStyle(
          fontSize: 17,
          color: Colors.red
        ),
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }

  //第三行text
  Widget _getTextRadio() {
    return new Container(
        margin: new EdgeInsets.only(top: 5),
        child: new Text(
          widget.data.radio,
          style: new TextStyle(
              fontSize: 15,
              color: Colors.deepOrange
          ),
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ));
  }

    //第四行text
    Widget _getTextMoney(){
      return  new Container(
        alignment: Alignment.topCenter,
        margin: new EdgeInsets.only(top: 2),
        child:new Text(
          "≈"+widget.data.money,
          style: new TextStyle(
            fontSize: 15,
            color: Colors.black45
          ),
          softWrap: false,
          overflow:TextOverflow.ellipsis
        ) ,
      );
    }



}

class HorizontalPageModel {
  int id;
  String money;
  String radio;
  String value;
  String name;

  HorizontalPageModel(this.id,this.money,this.radio,this.value,this.name);

}
