import 'package:flutter/material.dart';
import 'package:flutter_app_test/base/BaseMaterialApp.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/cupertino.dart';

class WebTextDetailePage extends StatefulWidget{
  String text;
  String url;
  WebTextDetailePage(this.text,this.url);

   @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _WebTextState();
  }
}


class _WebTextState extends State<WebTextDetailePage>{

  //是否加载
  bool  isLoading = true;
  // 标记当前页面是否是我们自定义的回调页面
  bool isLoadingCallbackPage = false;
  //webview插件提供对象，该对象用于webview各种操作
  FlutterWebviewPlugin webviewPlugin;
  //webview加载状态变化监听


  @override
  void initState() {
    // TODO: implement initState
//    Navigator.of(context).pushNamed("/b");
    _initWebViewPlugin();
    super.initState();
  }

  void _initWebViewPlugin(){
    webviewPlugin = new FlutterWebviewPlugin();
    webviewPlugin.onStateChanged.listen((WebViewStateChanged state){
      switch(state.type){
        case WebViewState.startLoad:
          print("_initWebViewPlugin startload 开始");
          setState(() {
            isLoading = true;
          });
          break;
        case WebViewState.shouldStart:
          print("_initWebViewPlugin shouldStart 准备");
          setState(() {
            isLoading = true;
          });
          break;
        case WebViewState.abortLoad:
          print("_initWebViewPlugin abortLoad 终止");
          break;
        case WebViewState.finishLoad:
          print("_initWebViewPlugin finishLoad 结束");
          setState(() {
            isLoading = false;
          });
          break;

      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    webviewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: _loadWeb(),
    );
  }


  Widget _loadWeb(){
    List<Widget> titleContent = new List();
    titleContent.add(
      new Container(
        width: 150,
        child:  new Text(
          widget.text,
          style: new TextStyle(color: Colors.white,),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ) ,
      )
      );
    if(isLoading) {
      //如果正在加载中 添加一个圆形的进度
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Container(width: 50.0,));

    return  new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: titleContent,

      ),
        iconTheme: new IconThemeData(color: Colors.white),
        leading: new IconButton(icon:new Icon(Icons.close),onPressed: (){Navigator.pop(context);},),

    ),
      withJavascript: true,
      withZoom: true,  // 允许网页缩放
      withLocalStorage: true, // 允许LocalStorage  bottom overflowid by

//      initialChild:  _getText(),
//      initialChild: new Container(
//        child: new Text("loading..."),
//      ),
    );


  }

  //展示text文本
  Widget _getText(){
    return new Text(
      widget.text,
      style: new TextStyle(
        fontSize: 12,
        color: Colors.black45
      ),
    );
  }


}
