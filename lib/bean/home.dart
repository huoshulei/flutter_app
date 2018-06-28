import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable()
class Subjects extends Object with _$SubjectsSerializerMixin {
  String key;
  String name;
  String order;

  Subjects(this.key, this.name, this.order);

  factory Subjects.fromJson(json) => _$SubjectsFromJson(json);
}

@JsonSerializable()
class NetClass extends Object with _$NetClassSerializerMixin {
  var img;
  var key;
  var order;

  NetClass(this.img, this.key, this.order);

  factory NetClass.fromJson(json) => _$NetClassFromJson(json);
}

@JsonSerializable()
class Book extends Object with _$BookSerializerMixin {
  var img;
  var sort;
  var url;

  Book(this.img, this.sort, this.url);
factory Book.fromJson(json) => _$BookFromJson(json);
}
@JsonSerializable()
class Information  extends Object with _$InformationSerializerMixin{
  var img;
  var key;
  var title;
  var pv;
  var nofcomment;
  var classifyname;
  var link;
  var cententtype;

  Information(this.img, this.key, this.title, this.pv, this.nofcomment,
      this.classifyname, this.link, this.cententtype);

  factory Information.fromJson(json) => _$InformationFromJson(json);
}