import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//LoginEntity.fromJson(jsonDecode(res.data) as Map<String, dynamic>)

const String mainEndPoint = 'https://be-travel-review.vercel.app';

final dio = Dio();

class LoginEntity {
  final String? accessToken;
  LoginEntity({this.accessToken});

  dynamic printAccessToken(context) {
    Navigator.pushReplacementNamed(context, "/intro");
  }

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      LoginEntity(accessToken: json['accessToken']);
}

//login
Future<LoginEntity> Api_login(
    {required String email, required String password, dynamic context}) async {
  Map<String, dynamic> req = {
    'email': email,
    'password': password,
  };
  try {
    Response res = await dio.post('$mainEndPoint/v1/auth/login', data: req);
    if (res.statusCode == 200) {
      final body = res.data;
      var login = LoginEntity(accessToken: body['accessToken']);
      // return Navigator.pushReplacementNamed(context, "/intro");
      return login.printAccessToken(context);
    } else {
      throw Exception('Login failed !!!! ');
    }
  } on Exception catch (e) {
    print('error : $e');
    rethrow;
  }
}
