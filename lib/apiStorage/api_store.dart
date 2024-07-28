import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginEntity {
  final String? username;
  final String? email;
  final String? password;
  final String? accessToken;
  LoginEntity({
    this.accessToken,
    this.username,
    this.email,
    this.password,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      LoginEntity(accessToken: json['accessToken']); //<--sai cho nay nay
}
