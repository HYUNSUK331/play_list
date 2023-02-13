import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:playlist/model/music.dart';
import 'package:playlist/model/play_list_model.dart';

class MusicListRepository {

    Future<List<Music>> musicList() async {
    var jsonResponse = json.decode( // musicList 만들기
        await rootBundle.loadString('assets/json/music.json'));
    List<Music> musicList = [];
    for (int i = 0; i < jsonResponse.length; i++) {
      musicList.add(Music.fromSnapshot(jsonResponse[i]));
    }
    return musicList;
  }

    Future<List<Music>> getmusicList(list) async {
      var jsonResponse = json.decode( // musicList 만들기
          await rootBundle.loadString('assets/json/music.json'));
      List<Music> musicList = [];
      for (int i = 0; i < jsonResponse.length; i++) {


        musicList.add(Music.fromSnapshot(jsonResponse[i]));
      }
      return musicList;
    }

}
MusicListRepository musicListRepository =
MusicListRepository();