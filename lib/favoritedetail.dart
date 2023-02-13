import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playlist/favoritmusic.dart';
import 'package:playlist/home_view.dart';
import 'package:playlist/musiclist.dart';
import 'package:playlist/repository/play_list_network_repository.dart';

class FavoriteDetail extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final int index;

  const FavoriteDetail({required this.snapshot, required this.index});

  @override
  State<FavoriteDetail> createState() => _FavoriteDetailState();
}
class _FavoriteDetailState extends State<FavoriteDetail> {
  bool favoriteTwo = true;
  String? key;
  String? search;
  String? title2;
  bool visibility = true;
  String? check;
  bool visibleCheck = true;
  final TextEditingController _textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.snapshot.data[widget.index].favoriteCheck == false ? visibleCheck = true : visibleCheck = false;
    HomeViewState? parent = context.findAncestorStateOfType<HomeViewState>();
    FavoriteMusicState? parent2 = context.findAncestorStateOfType<FavoriteMusicState>();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Visibility(
              visible: visibleCheck, // 숨기기
              child: Container(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // 이미지 파일 클릭하면 상세페이지로 이동
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        var indexCheck = widget.index;
                        var snapshotCheck = widget.snapshot;
                        Navigator.push(
                          //클릭하면 ImageDetail 페이지로 이동
                          context,
                          MaterialPageRoute(
                              builder: (context) => MusicList(
                                  snapshot: snapshotCheck,
                                  index:
                                  indexCheck)), //여기서 snapshot,index를 그대로 받아 ImageDetail로 전달
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                              child: Text(
                                widget.snapshot.data[widget.index].title,
                                style: TextStyle(color: Colors.black),
                              ) // 여기 0~5번 추가하는거
                          ),
                          Container(
                              child: IconButton(
                                  color: Colors.black,
                                  icon: Icon(
                                      widget.snapshot.data[widget.index].favoriteCheck
                                          ? Icons.favorite_border
                                          : Icons.favorite,
                                      color: widget.snapshot.data[widget.index].favoriteCheck ? null : Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      updateFavorite();
                                      print(visibleCheck);
                                      widget.snapshot.data[widget.index].favoriteCheck == true ? visibleCheck = true : visibleCheck = false;
                                      parent2?.setState(() {});
                                      setState(() {});
                                      print(visibleCheck);
                                    });
                                  })),
                          Container(
                              child: IconButton(
                                  onPressed: () async =>
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CupertinoActionSheet(
                                                  actions: [
                                                    CupertinoActionSheetAction(
                                                        child: Text('숨기기'),
                                                        onPressed: () {}),
                                                    CupertinoActionSheetAction(
                                                      child: Text('제목 수정하기'),
                                                      onPressed: () async =>
                                                      await showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                          context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    "변경할 제목을 입력하세요"),
                                                                content:
                                                                TextField(
                                                                  controller:
                                                                  _textController,
                                                                  onSubmitted:
                                                                      (text) {
                                                                    sendMsg(
                                                                        text);
                                                                  },
                                                                  //키보드로 엔터 클릭 시 호출
                                                                  decoration:
                                                                  InputDecoration(
                                                                    // labelText: '텍스트 입력',
                                                                    hintText:
                                                                    '텍스트를 입력해주세요',
                                                                    suffixIcon: _textController.text.isNotEmpty // 버튼
                                                                        ? Container(
                                                                      child: IconButton(
                                                                        //텍스트 지우는 버튼
                                                                        alignment: Alignment.centerRight,
                                                                        icon: const Icon(
                                                                          Icons.cancel,
                                                                        ),
                                                                        onPressed: () {
                                                                          _textController.clear();
                                                                          setState(() {});
                                                                        },
                                                                      ),
                                                                    )
                                                                        : null,
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                      child: Text(
                                                                          "OK"),
                                                                      onPressed:
                                                                          () async {
                                                                        if (_textController.text !=
                                                                            "") {
                                                                          updateTitle();
                                                                          parent?.setState(() {});
                                                                          Navigator.of(context).pop();
                                                                        } else
                                                                          (updateTitleTwo());
                                                                      })
                                                                ],
                                                              )),
                                                    ),
                                                    CupertinoActionSheetAction(
                                                      child: Text('삭제하기',
                                                          style: TextStyle(
                                                              color:
                                                              Colors.red)),
                                                      onPressed: () async {
                                                        deleteList();
                                                        Navigator.of(context)
                                                            .pop();
                                                        parent?.setState(() {});
                                                      },
                                                    ),
                                                  ],
                                                  cancelButton:
                                                  CupertinoActionSheetAction(
                                                    child: Text("취소"),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                  ))),
                                  icon: Icon(
                                    Icons.menu,
                                    color: Colors.black,
                                  ))),
                        ],
                      ))))
        ],
      ),
    );
  }

  void updateTitle() async {
    search = _textController.text;
    Navigator.of(context).pop();
    print("$search");
    _textController.clear();
    title2 = widget.snapshot.data[widget.index].playListKey;
    await playListNetworkRepository.updatePlayList(
        "$search", "$title2", []).then((value) => {setState(() {})});
  }

  void updateFavorite() async{
    if (widget.snapshot.data[widget.index].favoriteCheck == true) {
      favoriteTwo = false;
    } else if (widget.snapshot.data[widget.index].favoriteCheck == false) {
      favoriteTwo = true;
    }
    title2 = widget.snapshot.data[widget.index].playListKey;
    await playListNetworkRepository.updateFavorite(favoriteTwo, "$title2", []).then((value) => {setState(() {})});
  }

  void deleteList() async {
    key = widget.snapshot.data[widget.index].playListKey;
    await playListNetworkRepository.DeletePlayList("$key", []);
  }

  void updateTitleTwo() {
    Navigator.of(context).pop(); // 모달창 끄기
    _textController.clear(); //  텍스트 초기화
  }

  void sendMsg(String text) {
    _textController.clear();
    search = text;
    Navigator.of(context).pop();
  }
}
