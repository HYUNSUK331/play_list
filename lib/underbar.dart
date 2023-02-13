import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:playlist/favoritmusic.dart';
import 'package:playlist/home_view.dart';



class UnderBar extends StatefulWidget{

  @override
  State<UnderBar> createState() => _UnderBarState();
}

class _UnderBarState extends State<UnderBar>{
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
  void navigationTapped(int page) {  // 입력된 수의 페이즈로 이동해라
    pageController.jumpToPage(page);
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: AlwaysScrollableScrollPhysics(),

            controller: pageController,
            onPageChanged: onPageChanged,
            children: [
              HomeView(),
              FavoriteMusic(),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            barIcon(0),
            barIcon(1),
        ],
        ),
      ),
    );
  }
  Widget barIcon(int page) {  // 잘 모르겠는 연산자
    return InkWell(
      child: Container(
        height: 60,
        child:
        page == 0 ? Icon(Icons.layers) : Icon(Icons.heart_broken),
      ),
      onTap: () => {
        navigationTapped(page),
      },
    );
  }
}