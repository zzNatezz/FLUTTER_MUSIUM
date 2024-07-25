import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

//LoginEntity.fromJson(jsonDecode(res.data) as Map<String, dynamic>)

const String mainEndPoint = 'be-travel-review.vercel.app';

final dio = Dio();

class LoginEntity {
  final String? accessToken;
  LoginEntity({this.accessToken});

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      LoginEntity(accessToken: json['accessToken']);
}

//login
Future<LoginEntity> isLogin(String email, String password) async {
  Map<String, dynamic> req = {
    'email': email,
    'password': password,
  };
  Response res = await dio.post('$mainEndPoint/v1/auth/login', data: req);

  if (res.statusCode == 201) {
    final body = res.data;
    return LoginEntity(accessToken: body['accessToken']);
  } else {
    throw Exception('Login failed !!!! ');
  }
}
