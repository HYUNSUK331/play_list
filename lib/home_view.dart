import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:playlist/model/music.dart';
import 'package:playlist/pldetail.dart';
import 'package:playlist/plsy_list_controller.dart';
import 'package:playlist/repository/play_list_network_repository.dart';
import 'package:playlist/const/const.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  PlayListController playListController = Get.find();

  List<Music> resultMusicList = [];  // 뭔가 많이 나오기 시작
  late AssetsAudioPlayer _assetsAudioPlayer;
  bool isValue = false;
  final TextEditingController _textController = new TextEditingController();
  String? search;

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "플레이리스트",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () async =>
              await showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text("플레이리스트 제목을 입력하세요"),
                        content: TextField(
                          controller: _textController,
                          onSubmitted: (text) {
                            sendMsg(text);
                          }, //키보드로 엔터 클릭 시 호출
                          decoration: InputDecoration(
                            // labelText: '텍스트 입력',
                            hintText: '텍스트를 입력해주세요',
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
                              child: Text("OK"),
                              onPressed: () async {
                                if (_textController.text != "") {
                                  inputSet();
                                  // var jsonResponse = json.decode(
                                  //     await rootBundle.loadString(
                                  //         'assets/music/music.json')); //json 이건 어디서 무얼 불러오나???
                                  // print(jsonResponse[0]["id"]);
                                } else
                                  (inputSetTwo());
                              })
                        ],
                      )),
              icon: Icon(
                Icons.add,
                size: 35,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          InkWell(
            child:Text("Test"),
            onTap:(){
              print(Constants.musicList[0].name);
            }
          ),
          Container(
            height: 130,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.grey,
                    child: IconButton(
                        padding: EdgeInsets.all(30), // 패딩 설정
                        constraints: BoxConstraints(), // constraints
                        icon: Icon(
                          Icons.add,
                          color: Colors.redAccent,
                        ),
                        onPressed: () async => await showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text("플레이리스트 제목을 입력하세요"),
                                  content: TextField(
                                    controller: _textController,
                                    onSubmitted: (text) {
                                      sendMsg(text);
                                    }, //키보드로 엔터 클릭 시 호출
                                    decoration: InputDecoration(
                                      // labelText: '텍스트 입력',
                                      hintText: '텍스트를 입력해주세요',
                                      suffixIcon:
                                          _textController.text.isNotEmpty // 버튼
                                              ? Container(
                                                  child: IconButton(
                                                    //텍스트 지우는 버튼
                                                    alignment:
                                                        Alignment.centerRight,
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
                                        child: Text("OK"),
                                        onPressed: () async {
                                          if (_textController.text != "") {
                                            inputSet();
                                            // var jsonResponse = json.decode(
                                            //     await rootBundle.loadString(
                                            //         'assets/music/music.json')); //json 이건 어디서 무얼 불러오나???
                                            // print(jsonResponse[0]["id"]);
                                          } else
                                            (inputSetTwo());
                                        })
                                  ],
                                ))),
                  ),
                  Container(
                      width: 150,
                      child: Text("새로운 플레이리스트...",
                          style: TextStyle(color: Colors.redAccent))),
                  Container(
                    width: 50,
                  )
                ]),
          ),
          Container(
            child: Divider(
              color: Colors.black.withOpacity(0.2),
              thickness: 1.0,
            ),
          ),
          FutureBuilder(
              future: playListNetworkRepository.getPlayListModel(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.red),
                    ));
                  case ConnectionState.waiting:
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.red),
                    ));
                  default:
                    return Expanded(
                      flex: 6,
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PlDeail(
                              snapshot: snapshot,
                              index: index,
                            );
                          }),
                    );
                }
              }),
        ],
      ),
    );
  }

  void sendMsg(String text) {
    _textController.clear();
    search = text;
    Navigator.of(context).pop();
  }

  void inputSet() {
    search = _textController.text; // 화면에 입력한 내용 search에 반환
    Navigator.of(context).pop(); // 모달창 끄기
    _textController.clear(); //  텍스트 초기화
    playListNetworkRepository
        .setPlayList("$search", []).then((value) => {setState(() {})});
  }

  void inputSetTwo() {
    Navigator.of(context).pop(); // 모달창 끄기
    _textController.clear(); //  텍스트 초기화
  }
}
