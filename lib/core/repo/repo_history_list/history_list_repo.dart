import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:golobe/apiStorage/api_store.dart';
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
        for (int index in decoded.payload.length - 1) {
          SongEntity song = SongEntity(
              id: decoded.payload['_id'],
              title: decoded.payload['title'],
              author: decoded.payload['author'],
              image: decoded.payload['image'].url,
              song: decoded.payload['song'].url,
              view: decoded.payload['view']);
          songs.add(song);
        }
        return songs;
      } else {
        throw Exception('Listened list is on error');
      }
    } catch (e) {
      dev.log('Error --> ${e.toString()}');
      final List<SongEntity> songs = [];
      return songs;
    }
  }
}
