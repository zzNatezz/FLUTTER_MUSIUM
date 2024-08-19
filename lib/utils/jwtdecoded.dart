import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

dynamic jwtdecode(dynamic data) {
  final jsonEndcoded = jsonEncode(data);
  final jsonDecodedd = jsonDecode(jsonEndcoded);
  final decoded = JWT.decode(jsonDecodedd);
  return decoded;
}
