import 'package:flutter/material.dart';
import 'dart:async';

//item点击事件
typedef void onItemClick(int position,ItemTextView data);

//滚动的textview
class TextScrollView extends StatefulWidget{
  //当前位置
  int selectPositon;
  //数据
  List<ItemTextView> datas;
  //多长时间循环
  int duration;
  //高度
  double height ;
  //字体颜色
  Color textColor ;
  //字体大小
  double textSize;
  //行数
  int textLine;
  //点击事件
  onItemClick itemClick;

  TextScrollView(this.datas,this.height,{Key key,this.duration=3000,this.selectPositon=0,
  this.textColor=Colors.black45,this.textSize=12.0,this.textLine=1,
    this.itemClick
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  new _PageTextState();
  }


}

const MAX_COUNT = 0x888888;

//设置state
class _PageTextState extends State<TextScrollView>{
  //page监听器
  PageController controller;
  //计时器
  Timer timer;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
       height: widget.height,
        child:  new Stack(
        children: <Widget>[
          _getScrollText()
        ],
    ),
    );
//
  }
  @override
  void initState(){
    //初始化数据
    controller = new PageController();//initPage可以初始化位置
    //初始化
    _initPageScroll();
    super.initState();
  }

  void _initPageScroll(){
    start();
  }

  //滚动的view
  Widget _getScrollText(){
    return
      new PageView.builder(
        itemCount:  widget.datas.length > 0 ? MAX_COUNT : 0,
        controller: controller,//监听当前page
        onPageChanged:_onPageChage ,//下标更改
//          reverse: true,//水平方向相反
        scrollDirection: Axis.vertical,//垂直
        itemBuilder:(context,index){

         return  new InkWell(
            onTap: (){
              if(widget.itemClick != null) {
                int position = widget.selectPositon % widget.datas.length;
                ItemTextView item = widget.datas[position];
                widget.itemClick(position, item);
              }
            }, //按下事件
            child: new Align(
              alignment: Alignment.center,//居中显示
                child:new Text(
                  widget.datas[widget.selectPositon % widget.datas.length].text,
                  style: _setText(),
                  overflow: TextOverflow.ellipsis, //超出行数省略
                  maxLines: widget.textLine,//默认只显示1行
                ),//添加自定义的视图
            )
            );
        }
    );
  }
  //text
  TextStyle _setText(){
    return new TextStyle(
        fontSize: widget.textSize,
        color: widget.textColor,
    );
  }

  //更新Position
  void _onPageChage(index){
    widget.selectPositon = index % widget.datas.length;
    setState(() {});
  }

  void start(){
    stop();
    print("duration:${widget.duration} \t ${widget.datas.length}");
    timer = Timer.periodic(new Duration(milliseconds: widget.duration), (time){
      if(controller != null && widget.datas != null && widget.datas.length > 0) {
        controller.animateToPage(controller.page.toInt() + 1,
            duration: new Duration(milliseconds: 500), curve: Curves.linear);
      }
    });

  }

  void stop(){
    timer?.cancel();
    timer = null;
  }

  @override
  void dispose() {
    stop();
    // TODO: implement dispose
    super.dispose();
  }

}




//数据
class ItemTextView {
  String id;
  String text;
  ItemTextView(this.id,this.text);
}