import 'package:flutter/material.dart';
import 'package:flutter_app_test/http/DHttp.dart';
import 'package:flutter_app_test/widget/ViewPage.dart';
import 'package:flutter_app_test/model/MainBannerModel.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_app_test/model/BannerTestModel.dart';
import 'dart:async';
import 'package:flutter_app_test/widget/TestPage.dart';
import 'package:flutter_app_test/widget/TextScrollView.dart';
import 'package:flutter_app_test/page/main/WebTextDetailePage.dart';
import 'package:flutter_app_test/page/main/FindPage.dart';
import 'package:flutter_app_test/widget/ManiHorizontalPage.dart';
import 'package:flutter_app_test/common/Resource.dart';

class MainPage extends StatelessWidget{
   BuildContext fContext;
  MainPage({Key key,this.fContext}):super(key:key);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new MaterialApp(
      home:  new Scaffold(
        appBar: new AppBar(
          title: new Text("首页"),
        ),
        body:new CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            new SliverList(delegate: new SliverChildListDelegate(
              <Widget>[
                    //头部banner
                    new _MainHeadPage(),
                    //练习的banner
//          new TestPageView()
                    //滚动的文字
                    new TextScroll(fContext:fContext),
                    //添加平行滑动的视图
                    new MainHorizontalPage(),
                    //添加中部的view
                    new _CenterPage(),


              ]
            ))

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
      ),
      routes: {
        // "/a": (context) => PageA(),
        "/a":(_) => new FindPage(),
      },
    );


  }
}


//滚动的文字
class TextScroll extends StatefulWidget{
  BuildContext fContext;
  TextScroll({Key key,this.fContext}) : super (key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TextScrollState();
  }
}
class TextScrollState extends State<TextScroll>{
  List<ItemTextView> datas;

  @override
  void initState() {
    // TODO: implement initState
    _request();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new TextScrollView(datas,50,itemClick: (index,item){
//      Navigator.of(context).pushNamed("/a");//静态页面传值
    //动态传值
      Navigator.of(widget.fContext).push(new MaterialPageRoute(builder: (context){
        return new WebTextDetailePage(item.text,item.id);
      }));
    },);
  }
  void _request(){
    datas = new List();
    ItemTextView item01 = new ItemTextView("https://cn.bing.com/", "分支的管理分支的管理到目前为止,你已经学会了如何创建、合并和删除分支。""除此之外,我们还需要学习如何管理分支,在日后的常规工作中会经常用到下面");
    ItemTextView item02 = new ItemTextView("https://www.baidu.com/", " 北京消协对市场上销售的76个品牌的100个服装样品开展了比较试验。最终,25个样品未达到相关国标要求。其中,售价3800元的GIORGIO AR");
    ItemTextView item03 = new ItemTextView("https://www.sogou.com/", "《哪吒之魔童降世》累计票房超过10亿元,超越《西游记之大圣归来》成为国产动画电影票房新晋冠军。午后,影视股集体拉涨,上海电影收盘大涨近7");
    datas.add(item01);
    datas.add(item02);
    datas.add(item03);
    setState(() {

    });
  }
}


//头部viewpage
class _MainHeadPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MainHead();
  }
}
//viewpager
class _MainHead extends State<_MainHeadPage>{
  List<BannerItem> _list = new List();

  @override
  void initState(){
    _updateBanner();
    super.initState();
  }

  _updateBanner() async{
    var data = await new DHttp().sendMainBanner();
    MainBannerModel model = await MainBannerModel.fromJson(data);
    List<BannerItem> _list02 = new List();
    if(model.data != null) {
      for (int i = 0; i < model.data.length; i++) {
        BannerItem item = new BannerItem();
        item.itemImagePath = model.data.elementAt(i).image;
        item.itemText = new Text("");
        _list02.add(item);
      }
    }
    setState(() {
      _list = _list02;
    });
  }


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new BannerWidget(
      180.0,
      _list
    );
  }
}


//中部的view
class _CenterPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _CenterPageState();
  }

}

class _CenterPageState extends State<_CenterPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: new EdgeInsets.only(left: 15,right: 15,top: 0),
      height: 80,
      color: Colors.blue,
      alignment: Alignment.centerLeft,
      child: new Row(
        children: <Widget>[
          _centerTexe()
        ],
      )
//      new Align(
//        alignment: Alignment.centerLeft,
//        child:  new Column(
//          children: <Widget>[
////          new Text("hehe")
//            _centerTexe(),
//          ],
//        ) ,
//      )
//

    );
  }

  //文字
  Widget _centerTexe() => new Row(
//    crossAxisAlignment: CrossAxisAlignment.,
    children: <Widget>[
      new Container(
        width: MediaQuery.of(context).size.width / 1.7,
//            height: context.size.height,
        color: Colors.yellow,
        alignment: Alignment.center,
        margin: new EdgeInsets.only(top: 10,bottom: 10),
        child: new Column(
//                mainAxisAlignment: CrossAxisAlignment.center,
//                verticalDirection:VerticalDirection.down ,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Align(
              alignment: Alignment.centerLeft,
              child:  new Text(
                "第三方场外",
                style: new TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,

                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ),
            new Align(
              alignment: Alignment.centerLeft,
              child:new Text(
                "安全、快捷的出入境交易",
                style: new TextStyle(
                    fontSize: 12,
                    color: Colors.black54
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign:TextAlign.start,
              ) ,
            )

          ],
        ),

      ),

      //右侧图片
      new Image.asset(
        Images.icon_c2c,
        width: 10,
          height: 50,
      )

    ],

  );


}

