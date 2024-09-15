import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/consttants/api_path.dart';
import 'package:golobe/utils/mini_widgets.dart';

class SongListRepo {
  final dio = Dio();
  Future<List<SongEntity>> fetchHistory({String userId = ""}) async {
    try {
      if (userId == "") throw Error();
      final req = await dio.get('${ApiPath.historySongEP}/$userId');
      if (req.statusCode == 200) {
        final decoded = jwtdecode(req.data);

        List<SongEntity> songs = [];
        late dynamic value;

        for (value in decoded.payload.values) {
          if (value is Map<String, dynamic>) {
            SongEntity song = SongEntity(
                id: value['_id'],
                title: value['title'],
                author: value['author'],
                image: value['image'],
                song: value['song'],
                view: value['view']);
            songs.add(song);
          } else {
            break;
          }
        }
        return songs;
      } else {
        dev.log('hist_list repo line 35');
        final List<SongEntity> songs = [];
        return songs;
      }
    } catch (e) {
      dev.log('hist_list repo line 40 --> ${e.toString()}');
      final List<SongEntity> songs = [];
      return songs;
    }
  }
}
