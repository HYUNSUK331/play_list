import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:playlist/const/firestore_keys.dart';
import 'package:playlist/model/play_list_model.dart';

class PlayListNetworkRepository {
  Future<List<PlayListModel>> getPlayListModel() async {
    final CollectionReference playListCollRef =
        FirebaseFirestore.instance.collection(COLLECTION_PLAYLIST);
    List<PlayListModel> resultPlayList = [];
    QuerySnapshot querySnapshot = await playListCollRef.get();
    // where(KEY_TITLE, isEqualTo: "아이유").get();

    print("querySnapshot.docs.length");
    print(querySnapshot.docs.length);
    querySnapshot.docs.forEach((element) {
      resultPlayList.add(PlayListModel.fromSnapshot(element));
    });
    return resultPlayList;
  }

  // 데이터 등록
  Future<void> setPlayList(String title, list) async {
    final CollectionReference playListCollRef =
        FirebaseFirestore.instance.collection(COLLECTION_PLAYLIST);
    DocumentReference documentReference = playListCollRef.doc();

    await FirebaseFirestore.instance.runTransaction((tx) async {
      tx.set(documentReference, {
        KEY_TITLE: title,
        KEY_PLAY_LIST_KEY: documentReference.id,
        KEY_FAVORITE: true,
        KEY_MUSIC_LIST: list
      });
    });
  }

  Future<void> DeletePlayList(String title, list) async {
    final CollectionReference playListCollRef =
        FirebaseFirestore.instance.collection(COLLECTION_PLAYLIST);
    DocumentReference documentReference = playListCollRef.doc(title);

    await documentReference.delete();
  }

  Future<void> updatePlayList(String title,String title2, list) async {  // 키 값도 가져오기
    final CollectionReference playListCollRef =
        FirebaseFirestore.instance.collection(COLLECTION_PLAYLIST);
    DocumentReference documentReference = playListCollRef.doc(title2);

    await documentReference.update({KEY_TITLE:title});
  }

  Future<void> updateFavorite(bool title,String title2, list) async {  // 키 값도 가져오기
    final CollectionReference playListCollRef =
    FirebaseFirestore.instance.collection(COLLECTION_PLAYLIST);
    DocumentReference documentReference = playListCollRef.doc(title2);

    await documentReference.update({KEY_FAVORITE:title});
  }
  Future<void> updatelist(String title2, list) async {  // 키 값도 가져오기
    final CollectionReference playListCollRef =
    FirebaseFirestore.instance.collection(COLLECTION_PLAYLIST);
    DocumentReference documentReference = playListCollRef.doc(title2);

    await documentReference.update({KEY_MUSIC_LIST:list});
  }
}



PlayListNetworkRepository playListNetworkRepository =
    PlayListNetworkRepository();
