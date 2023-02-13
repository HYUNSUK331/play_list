import 'package:get/get.dart';
import 'package:playlist/model/play_list_model.dart';

class PlayListController{
  RxList<PlayListModel> playList = RxList<PlayListModel>();

  set setPlayListModel(List<PlayListModel> value){
    playList(value);
  }

  // void updatePlayModel(PlayListModel value, int index){
  //   playList[index] = value;
  // }

  void updateElementPlayModel(int index, bool isFav){
    playList[index].favoriteCheck = false;

  }
}