import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences _prefs;

get isLogin => get('isLogin', false);

set isLogin(bool value) => save('isLogin', value);

get userId => get('user_id', "");

set userId(String value) => save('user_id', value);

get grade => get('grade', "");

set grade(String value) => save('grade', value);

get token => get('token', "");

set token(String value) => save('token', value);

save(String key, value) async {
  if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  switch (value.runtimeType) {
    case String:
      _prefs.setString(key, value);
      break;
    case bool:
      _prefs.setBool(key, value);
      break;
    case int:
      _prefs.setInt(key, value);
      break;
    case double:
      _prefs.setDouble(key, value);
      break;
    default:
      break;
  }
}

Future<dynamic> get(key, [defValue = '']) async {
  var value = defValue;
  if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  switch (value.runtimeType) {
    case String:
      value = _prefs.getString(key);
      break;
    case bool:
      value = _prefs.getBool(key);
      break;
    case int:
      value = _prefs.getInt(key);
      break;
    case double:
      value = _prefs.getDouble(key);
      break;
    default:
      break;
  }
  return value;
}
