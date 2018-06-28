//import 'dart:convert';
//import 'dart:io';
//import 'package:dio/dio.dart';
////import 'package:flutter_app/net/api.dart';
////import 'package:flutter_app/bean/user.dart';
////import 'package:flutter_app/net/dio.dart';
//
//main() async {
//  Dio dio = new Dio(new Options(
//      baseUrl: 'http://10.20.0.121:8080/platform_Backstage_api/',
//      connectTimeout: 5000,
//      receiveTimeout: 3000));
//  Response response=await dio.get("https://gank.io/api/random/data/%E7%A6%8F%E5%88%A9/10");
//  print(response.data);
//
////  var loginResponse = await login(Login("11", "11"));
////  print(loginResponse);
////  dartHandler(HttpRequest request) {
////    request.response.headers.contentType = new ContentType('text', 'plain');
////    var m = {};
////    m['code'] = 200;
////    var l = [];
////    l.addAll(['s', 's', 'd']);
////    m['res'] = l;
////    var encode = json.encode(m);
////    request.response.write(encode);
////    request.response.close();
////  }
////
////  var requests = await HttpServer.bind('127.0.0.1', 8888);
////  await for (var request in requests) {
////    print('Got request for ${request.uri.path}');
////    if (request.uri.path == '/languages/dart') {
////      dartHandler(request);
////    } else {
////      request.response.write('Not found');
////      request.response.close();
////    }
////  }
//}
