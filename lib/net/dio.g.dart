// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Header _$HeaderFromJson(Map<String, dynamic> json) => new Header(
    appId: json['appId'] as String,
    v: json['v'] as String,
    os: json['os'] as String,
    terminalType: json['terminalType'] as int,
    channel: json['channel'] as String,
    terminalid: json['terminalid'] as String,
    timestamp: json['timestamp'] as String,
    token: json['token'] as String,
    sign: json['sign'] as String,
    userId: json['userId'] as String);

abstract class _$HeaderSerializerMixin {
  String get appId;
  String get v;
  String get os;
  int get terminalType;
  String get channel;
  String get terminalid;
  String get timestamp;
  String get token;
  String get sign;
  String get userId;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'appId': appId,
        'v': v,
        'os': os,
        'terminalType': terminalType,
        'channel': channel,
        'terminalid': terminalid,
        'timestamp': timestamp,
        'token': token,
        'sign': sign,
        'userId': userId
      };
}
