import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:playlist/favoritedetail.dart';
import 'package:playlist/pldetail.dart';
import 'package:playlist/repository/play_list_network_repository.dart';


class FavoriteMusic extends StatefulWidget {
  const FavoriteMusic({super.key});

  @override
  State<FavoriteMusic> createState() => FavoriteMusicState();
}

class FavoriteMusicState extends State<FavoriteMusic> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final assetsAudioPlayer = AssetsAudioPlayer();

    assetsAudioPlayer.open(
      Audio("assets/json/music_2.mp3"),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("관심목록"),
        centerTitle: true,
      ),
      body: Container(alignment: Alignment.topRight,
        child: Column(
            children:[
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
                              return FavoriteDetail(
                                snapshot: snapshot,
                                index: index,
                              );
                            }),
                      );
                  }
                }),
            ]),
      ),
    );

  }
}