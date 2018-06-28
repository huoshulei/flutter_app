import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/net/dio.dart';
import 'package:flutter_app/bean/user.dart';
import 'package:flutter_app/bean/home.dart';

Future<LoginResponse> login(Login request) async {
  return dio.post('user/login', data: json.encode(request)).then((response) {
    print('===============toString==============2${response.data}');
    return LoginResponse.fromJson(response.data);
  });
}

Future<List<Subjects>> subjects(String key) async {
  return dio.get('common/getSubjectList', data: key).then((response) {
    return response.data
        .map<Subjects>((obj) => Subjects.fromJson(obj))
        .toList();
  });
}

Future<List<NetClass>> recommendCourses() async {
  return dio.get('netcourse/recommendList').then((response) {
    return response.data
        .map<NetClass>((obj) => NetClass.fromJson(obj))
        .toList();
  });
}

Future<List<Book>> recommendBooks() async {
  return dio.get('advert/list', data: '{"adspace":"tsjx"}').then((response) {
    return response.data.map<Book>((obj) => Book.fromJson(obj)).toList();
  });
}

Future<List<Information>> recommendInformation(int page) async {
  return dio
      .get('information/recommendList', data: '{"page":"$page","step":"10"}')
      .then((response) {
        print(response.data);
    return response.data
        .map<Information>((obj) => Information.fromJson(obj))
        .toList();
  });
}
