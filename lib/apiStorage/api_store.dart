import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String mainEndPoint = 'be-travel-review.vercel.app';

class LoginEntity {
  final String email;
  final String password;
  LoginEntity({required this.email, required this.password});

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      LoginEntity(email: json['email'], password: json['password']);
}

//login
// Future<LoginEntity> isLogin(String email, String password) async {
//   Map<String, dynamic> req = {
//     'email': email,
//     'password': password,
//   };
//   final uri = Uri.parse('$mainEndPoint/v1/auth/login');
//   final res = await http.post(uri, body: req);

//   if(res.statusCode == 201){
//     return LoginEntity.fromJson(JSON)
//   }
// }à
