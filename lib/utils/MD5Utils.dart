import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

String encrypt(String plaintext) {
  var hexDigits = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f'
  ];
  var btInput = utf8.encode(plaintext);
  var md5 = crypto.md5;
  var digest = md5.convert(btInput);
  var bytes = digest.bytes;
  var str = '';
  bytes.forEach((byte) {
    str += hexDigits[byte >> 4 & 0xf];
    str += hexDigits[byte & 0xf];
  });
  return str;
}
