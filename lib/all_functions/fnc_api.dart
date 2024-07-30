import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/apiStorage/api_store.dart';
import 'package:golobe/core/consttants/api_path.dart';

final Dio dio = Dio();

Future<LoginEntity> Api_login(
    {required String email,
    required String password,
    required BuildContext context}) async {
  Map<String, dynamic> req = {
    'username': email,
    'password': password,
  };
  try {
    Response res = await dio.post(ApiPath.loginEndPoint, data: req);
    if (res.statusCode == 200) {
      late dynamic login;
      if (context.mounted) {
        context.pushReplacementNamed('/intro');
      }
      // Navigator.pushReplacementNamed(context, '/intro');
      final body = res.data;
      // final jwtDecoded = JWT.decode(body);
      // print("body ==> $body");
      // print('jwtdecoded => ${jwtDecoded.payload}');
      return login = LoginEntity(accessToken: body);
    } else {
      throw Exception('Login failed !!!! ');
    }
  } on Exception catch (e) {
    print('error : $e');
    rethrow;
  }
}
