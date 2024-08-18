import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/consttants/api_path.dart';

class HistoryListRepo {
  final dio = Dio();
  Future<List<SongEntity>> fetchHistory(String userId) async {
    try {
      final req = await dio.get('${ApiPath.HistorySongEP}/$userId');

      if (req.statusCode == 200) {
        final jsonEndcoded = jsonEncode(req.data);
        final jsonDecodedd = jsonDecode(jsonEndcoded);
        final decoded = JWT.decode(jsonDecodedd);
        List<SongEntity> songs = [];
        for (dynamic i in decoded.payload) {
          SongEntity song = SongEntity(
              id: i['_id'],
              title: i['title'],
              author: i['author'],
              image: i['image'],
              song: i['song'],
              view: i['view']);
          songs.add(song);
        }
        dev.log('songs ---> ${songs.toString()}');
        return songs;
      } else {
        dev.log('Danh sách nghe lại đang bị lỗi');
        final List<SongEntity> songs = [];
        return songs;
      }
    } catch (e) {
      dev.log('Error --> ${e.toString()}');
      final List<SongEntity> songs = [];
      return songs;
    }
  }
}
