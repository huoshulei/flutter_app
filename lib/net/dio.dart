import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_app/utils/sp_utils.dart';

part 'dio.g.dart';

final Dio dio = Dio(Options(
  baseUrl: 'http://10.20.0.121:8080/platform_Backstage_api/',
  connectTimeout: 5000,
  receiveTimeout: 10000,
  contentType: ContentType.JSON,
))
  ..interceptor.request.onSend = (options) async {
    if (options.headers['authorization'] == null) {
      options.headers['authorization'] = await _getHeader();
      return options;
    } else {
      return options;
    }
  }
  ..interceptor.response.onSuccess = (response) {
    if (response.data != null) {
      var data = response.data;
//      print(response.data.runtimeType);
      if (response.data is String) {
        data = json.decode(response.data);
//        print('ssss'+data.runtimeType);
      }
      if (data['code'] == 200) {
        if (data['results']['ret'] == 100) {
          if (data['results']['list'] == null)
            return data['results']['body'];
          else
            return data['results']['list'];
        } else {
          throw data['results']['msg'];
        }
      } else {
        throw response;
      }
    }
    return response;
  }
  ..interceptor.response.onError = (DioError e) {
    print('=============================9$e');
  };

Future<String> _getHeader() async {
  var header = Header();
  header.timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  header.userId = await userId;
  header.token = await token;

  return json.encode(header);
//  return '{"appId":"223543530112693760","channel":"","os":"android","sign":"","terminalType":1,"terminalid":"{"gradekey":"210667505918723450","sectionkey":"211408606820734464","token":"1d430b6b07e012b1cfb25aff4817432ae6ee95532b51e6ecba59be0ae7010421","userId":"937436793560039424"}","timestamp":"1528879126827","token":"1d430b6b07e012b1cfb25aff4817432ae6ee95532b51e6ecba59be0ae7010421","userId":"937436793560039424","v":"1"}';
}

@JsonSerializable()
class Header extends Object with _$HeaderSerializerMixin {
  String appId;
  String v;
  String os;
  int terminalType;
  String channel;
  String terminalid;
  String timestamp;
  String token;
  String sign;
  String userId;

  Header(
      {this.appId: "223543530112693760",
      this.v: '1',
      this.os: 'android',
      this.terminalType: 1,
      this.channel:'',
      this.terminalid:'asdfghjklqwertyuiopmnbvcxzsadfgr',
      this.timestamp,
      this.token,
      this.sign:'',
      this.userId});

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
}
