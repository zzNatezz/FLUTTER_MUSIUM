import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:golobe/core/consttants/request_response.dart';

final _baseOption = BaseOptions(responseType: ResponseType.json);

class ApiClient {
  late final Dio _dio;
  late Options? options;

  ApiClient() : _dio = Dio(_baseOption);

  Future<RequestResponse> fetPost(String url,
      {Map<String, dynamic>? data}) async {
    try {
      final request = await _dio.post(
        url,
        data: data,
      );

      return RequestResponse(jsonEncode(request.data), true, 200);
    } catch (e, s) {
      print('123 : $e, $s');
      return RequestResponse('loi', false, 500);
    }
  }
}
