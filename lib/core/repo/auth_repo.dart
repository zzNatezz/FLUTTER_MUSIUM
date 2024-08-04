import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as devlog;
import 'package:golobe/core/consttants/api_login.dart';
import 'package:golobe/core/consttants/api_path.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class AuthRepo {
  // final ApiClient _apiClient = ApiClient();
  Future<ClientModel> authLogin({
    BuildContext? context,
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'username': email,
        'password': password,
      };
      Response req = await dio.post(ApiPath.loginEndPoint, data: data);
      final jsonEncodde = jsonEncode(req.data);

      final jsondecodde = jsonDecode(jsonEncodde);

      final decoded = JWT.decode(jsondecodde);

      if (req.statusCode == 200) {
        context!.goNamed('intro');
        return ClientModel(accessToken: decoded.payload);
      } else {
        return ClientModel(error: true);
      }
    } catch (e) {
      devlog.log('error due to --> $e');
      return ClientModel(error: true);
    }
  }
}
