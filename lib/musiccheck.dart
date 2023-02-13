import 'package:flutter/material.dart';
import 'package:playlist/const/const.dart';
import 'package:playlist/home_view.dart';
import 'package:playlist/model/music.dart';
import 'package:playlist/repository/play_list_network_repository.dart';

class MusicCheck extends StatefulWidget {
  final String playListKey;

  const MusicCheck({required this.playListKey});

  @override
  State<MusicCheck> createState() => _MusicCheckState();
}

class _MusicCheckState extends State<MusicCheck> {
  String? singerName;
  String? musicName;
  List<bool> isCheckList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<Music> musicList = [];


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print("jsonResponse[0]");
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.backspace_outlined),
              color: Colors.black,
            ),
            title: Text(
              "음원추가",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () {})
            ]),
        body: Column(
          children: [
            for (int i = 0; i < Constants.musicList.length; i++)
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              child: Image.network(
                            Constants.musicList[i].image,
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                          )),
                          Row(children: [
                            Container(
                              child: Text(Constants.musicList[i].name),
                            ),
                            Container(child: Text(" - ")),
                            Container(
                              child: Text(Constants.musicList[i].title),
                            ),
                          ]),
                          Container(
                            child: Checkbox(
                              value: isCheckList[i],
                              onChanged: (value) {
                                setState(() {
                                  isCheckList[i] = value!;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.2),
                        thickness: 1.0,
                      )
                    ],
                  )),
            Container(
              padding: EdgeInsets.all(50),
              child: ElevatedButton(onPressed: () async {
                List<String> musicList =  [];
                for(int i = 0; i < Constants.musicList.length; i++){
                  if(isCheckList[i] == true){
                    musicList.add(Constants.musicList[i].id);
                    ///widget.snapshot.data[widget.index].lengthist == Constants.musicList[i].id;
                  }
                }
                await playListNetworkRepository.updatelist(widget.playListKey,musicList);
              },
                  style:ElevatedButton.styleFrom(primary: Colors.black),child: Text("확인")),
            ),
          ],
        ));
  }
}
