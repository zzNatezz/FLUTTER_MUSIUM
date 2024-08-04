import 'dart:developer' as devlog;

class ClientModel {
  final Map<String, dynamic>? accessToken;
  bool error;

  ClientModel({this.accessToken, this.error = false});
}

// class ApiClient {
//   final _dio = Dio();
//   late Options? option;

//   Future<ClientModel> fetch(String url, Map<String, dynamic>? data) async {
//     try {
//       final req = await _dio.post(url, data: data);
//       final toString = jsonEncode(req.data);
//       return ClientModel(accessToken: toString);
//     } catch (e) {
//       devlog.log('loi : $e');
//       return ClientModel(accessToken: 'error', error: true);
//     }
//   }
// }
