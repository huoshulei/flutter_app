// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    new LoginResponse(json['token'] as String, json['userId'] as String,
        json['sectionkey'] as String, json['gradekey'] as String);

abstract class _$LoginResponseSerializerMixin {
  String get token;
  String get userId;
  String get sectionkey;
  String get gradekey;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'token': token,
        'userId': userId,
        'sectionkey': sectionkey,
        'gradekey': gradekey
      };
}

Login _$LoginFromJson(Map<String, dynamic> json) =>
    new Login(json['username'] as String, json['password'] as String);

abstract class _$LoginSerializerMixin {
  String get username;
  String get password;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'username': username, 'password': password};
}
