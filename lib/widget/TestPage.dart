import 'package:flutter/material.dart';
import 'package:flutter_app_test/http/DHttp.dart';
import 'package:flutter_app_test/widget/ViewPage.dart';
import 'package:flutter_app_test/model/MainBannerModel.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_app_test/model/BannerTestModel.dart';
import 'dart:async';
//简单轮播图

//pageview
class TestPageView extends StatefulWidget {
  int bannerLength ; //banner长度
  double height = 180;//banner高度
  List<_ItemBanner> data = new List();//数据
  int duration = 3000;//间隔轮询时间
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _TestPageState();
  }

}
const MAX_COUNT = 0x7fffffff;
class _TestPageState extends State<TestPageView>{

  PageController controller;//监听下标
  Timer timer ; //计时器
  int _selectPosition ;//当前选择的下标

  @override
  void initState(){
    _requestBanner();
    double current = widget.data.length > 0
        ? (MAX_COUNT / 2) - ((MAX_COUNT / 2) % widget.data.length)
        : 0.0;
    print("initState  : ${current}");
    controller = new PageController();
    _initPageAutoScroll();
    super.initState();
  }

  //请求数据
  _requestBanner() async{
    var d = await new DHttp().sendMainBanner();
    //json data
    BannerTestModel model = BannerTestModel.fromJson(d);
    for(var item in model.data){
      widget.data.add(new _ItemBanner(item.image));
    }
    //刷新数据
    setState(() {
      widget.bannerLength = widget.data.length;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: widget.height,
      child: new Stack(
        children: <Widget>[
          _getPageViewWidget(),

        ],
      ),
    );
  }
  //加载page
  Widget _getPageViewWidget() {
    return new PageView.builder(
      itemCount: widget.data.length > 0 ? MAX_COUNT : 0,//数量
      controller: controller,
      onPageChanged: _onPageChage,//更改页面的方法
      itemBuilder: (context,index){
        return new InkWell(
          onTap: (){
            print("点击事件");
          },
          child:new Container(
            padding: new EdgeInsets.only(left: 10,right: 10),
            child:  new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image:widget.data[index % widget.data.length].imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ) ,
        );
      },

    );
  }
  //更改页面
  int _lastPosition;
  void _onPageChage(index){
    _selectPosition = index % widget.data.length;
    print("_onPageChage : index:{$index} \t select:${_selectPosition}");
    setState(() {

    });
  }

  //初始化滚动
  void _initPageAutoScroll(){
    start();
  }
  //启动倒计时
  start(){
    stop();
    timer = Timer.periodic(new Duration(milliseconds: widget.duration), (time){
      //page 页面  duration 动画时间  curve动画样式
      if(widget.data != null && widget.data.length > 0 && controller != null ) {
        print("timer controller.page : ${controller.page.toInt()+1}");
        controller.animateToPage(controller.page.toInt() + 1,
            duration: Duration(milliseconds: 300), curve: Curves.linear);

      }
    });
  }
  //停止
  stop(){

    timer?.cancel();
    timer = null;

  }
  @override
  void dispose() {
    stop();
    super.dispose();
  }
}

class _ItemBanner {
  String imageUrl;
  _ItemBanner(this.imageUrl);
}
