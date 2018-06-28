import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class LoginResponse extends Object with _$LoginResponseSerializerMixin {
  String token;

  String userId;

  String sectionkey;

  String gradekey;

  LoginResponse(this.token, this.userId, this.sectionkey, this.gradekey);

//  List<Section> list;
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class Login extends Object with _$LoginSerializerMixin {
  String username;

  String password;

  Login(this.username, this.password);

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
}
