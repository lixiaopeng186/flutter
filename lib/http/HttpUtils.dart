import 'package:flutter_app_test/common/UrlAddress.dart';
import 'dart:io';
import 'dart:convert';
//请求
dynamic get(String url) async{
  HttpClient httpClient = new HttpClient();
  Uri uri = new Uri.http(UrlAddress.base_url,url);
  //带请求参数
//  var uri = new Uri.http(UrlAddress.base_url, later,{});
  HttpClientRequest request = await httpClient.getUrl(uri);
  //设置header
//  request.headers.add("cookie", "423wwwer");
  HttpClientResponse response = await request.close();
  //请求成功
  if(response.statusCode == HttpStatus.ok) {
    var responseBody = await response.transform(Utf8Decoder()).join();
    // 解析 json 字符串，返回的是 Map<String, dynamic> 类型
    var data = json.decode(responseBody);

    print("返回参数:"+responseBody.toString());
    return data;
  }
  //关闭
  httpClient.close();
}

