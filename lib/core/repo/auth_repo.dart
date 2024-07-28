import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:golobe/core/consttants/api_client.dart';
import 'package:golobe/core/consttants/api_path.dart';

class AuthRepo {
  Future<Map<String, dynamic>> authLogin(
      {required String email, required String password}) async {
    try {
      final req = await ApiClient().fetPost(ApiPath.mainEndPoint, data: {
        'username': email,
        'password': password,
      });
      final respon = jsonDecode(req.data);
      final decode = JWT.decode(respon);
      if (!req.hasError) {
        return {'success': true, 'data': decode};
      } else {
        return {'success': false, 'mes': 'loi'};
      }
    } catch (e) {
      return {'success': false, 'mes': 'loi2'};
    }
  }
}
