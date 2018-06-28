// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Subjects _$SubjectsFromJson(Map<String, dynamic> json) => new Subjects(
    json['key'] as String, json['name'] as String, json['order'] as String);

abstract class _$SubjectsSerializerMixin {
  String get key;
  String get name;
  String get order;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'key': key, 'name': name, 'order': order};
}

NetClass _$NetClassFromJson(Map<String, dynamic> json) =>
    new NetClass(json['img'], json['key'], json['order']);

abstract class _$NetClassSerializerMixin {
  dynamic get img;
  dynamic get key;
  dynamic get order;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'img': img, 'key': key, 'order': order};
}

Book _$BookFromJson(Map<String, dynamic> json) =>
    new Book(json['img'], json['sort'], json['url']);

abstract class _$BookSerializerMixin {
  dynamic get img;
  dynamic get sort;
  dynamic get url;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'img': img, 'sort': sort, 'url': url};
}

Information _$InformationFromJson(Map<String, dynamic> json) => new Information(
    json['img'],
    json['key'],
    json['title'],
    json['pv'],
    json['nofcomment'],
    json['classifyname'],
    json['link'],
    json['cententtype']);

abstract class _$InformationSerializerMixin {
  dynamic get img;
  dynamic get key;
  dynamic get title;
  dynamic get pv;
  dynamic get nofcomment;
  dynamic get classifyname;
  dynamic get link;
  dynamic get cententtype;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'img': img,
        'key': key,
        'title': title,
        'pv': pv,
        'nofcomment': nofcomment,
        'classifyname': classifyname,
        'link': link,
        'cententtype': cententtype
      };
}
