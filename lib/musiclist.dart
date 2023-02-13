import 'package:flutter/material.dart';
import 'package:playlist/const/const.dart';
import 'package:playlist/home_view.dart';
import 'package:playlist/model/music.dart';
import 'package:playlist/musiccheck.dart';

class MusicList extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final int index;

  const MusicList({required this.snapshot, required this.index});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  void initState() {
    super.initState();
  }

  List<String> musicListShort = [];

  @override
  Widget build(BuildContext context) {
    setState(() {});
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
              "음원리스트",
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
                  onPressed: () async {
                    Navigator.push(
                      //클릭하면 ImageDetail 페이지로 이동
                      context,
                      MaterialPageRoute(
                          builder: (context) => MusicCheck(
                              playListKey: widget.snapshot.data[widget.index]
                                  .playListKey)), //여기서 snapshot,index를 그대로 받아 ImageDetail로 전달
                    );
                  })
            ]),
        body: Column(
          children: [
            for (int i = 0; i < widget.snapshot.data[widget.index].musicList.length; i++) ...[
              // 4번 music_1,music_2...
              for (int j = 0; j < Constants.musicList.length; j++) ...[
                if (widget.snapshot.data[widget.index].musicList[i] ==
                    Constants.musicList[j].id) ...[
                  SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  child: Image.network(
                                Constants.musicList[j].image,
                                height: 50,
                                width: 50,
                                fit: BoxFit.fill,
                              )),
                              Row(children: [
                                Container(
                                  child: Text(Constants.musicList[j].name),
                                ),
                                Container(child: Text(" - ")),
                                Container(
                                  child: Text(Constants.musicList[j].title),
                                ),
                              ]),
                            ],
                          ),
                          Divider(
                            color: Colors.black.withOpacity(0.2),
                            thickness: 1.0,
                          )
                        ],
                      )),
                ] else
                  ...[]
              ]
            ]
          ],
        ));
  }
}
