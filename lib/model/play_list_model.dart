import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:playlist/const/firestore_keys.dart';

class PlayListModel {
  String playListKey;
  String title;
  dynamic musicList;
  bool favoriteCheck;


  PlayListModel.fromMap(Map<String, dynamic> map)
      : playListKey = map[KEY_PLAY_LIST_KEY],
        title = map[KEY_TITLE],
        musicList = map[KEY_MUSIC_LIST],
        favoriteCheck = map[KEY_FAVORITE];

  PlayListModel.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data() as Map<String, dynamic>);

}