import 'package:flutter/material.dart';
import 'package:flutter_app/home/home_widget.dart';
import 'package:flutter_app/learn/learn_widget.dart';
import 'package:flutter_app/community/community_widget.dart';
import 'package:flutter_app/mine/mine_widget.dart';
import 'package:flutter_app/utils/sp_utils.dart';
import 'package:flutter_app/common/login_widget.dart';

main() => runApp(MaterialApp(
      home: MainPage(),
      theme:
          ThemeData(primaryColor: Colors.white, backgroundColor: Colors.white),
    ));

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateHomePage();
}

class _StateHomePage extends State<MainPage> {
  var _currentIndex = 0;
  final _titleFont = const TextStyle(color: Colors.black, fontSize: 10.0);
  var _listPage;
  var _currentPage;

  @override
  void initState() {
    // TODO: implement initState
    get('isLogin', false).then((isLogin) {
      isLogin
          ? null
          : Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LoginWidget();
            }));
    });
    super.initState();
    _listPage = [HomePage(), LearnPage(), CommunityPage(), MinePage()];
    _currentPage = _listPage[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
          child: _currentPage,
        ),
        bottomNavigationBar: SizedBox(
            height: 49.0,
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(
                      _currentIndex == 0
                          ? 'assets/icon/home_seleted.png'
                          : 'assets/icon/home_normal.png',
                      width: 20.0,
                      height: 20.0,
                    ),
                    title: Text(
                      '首页',
                      style: _titleFont,
                    )),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      _currentIndex == 1
                          ? 'assets/icon/learn_seleted.png'
                          : 'assets/icon/learn_normal.png',
                      width: 20.0,
                      height: 20.0,
                    ),
                    title: Text(
                      '学习',
                      style: _titleFont,
                    )),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      _currentIndex == 2
                          ? 'assets/icon/community_seleted.png'
                          : 'assets/icon/community_normal.png',
                      width: 20.0,
                      height: 20.0,
                    ),
                    title: Text(
                      '社区',
                      style: _titleFont,
                    )),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      _currentIndex == 3
                          ? 'assets/icon/mine_seleted.png'
                          : 'assets/icon/mine_normal.png',
                      width: 20.0,
                      height: 20.0,
                    ),
                    title: Text(
                      '我的',
                      style: _titleFont,
                    )),
              ],
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                if (index != _currentIndex)
                  setState(() {
                    _currentIndex = index;
                    _currentPage = _listPage[_currentIndex];
                  });
                else
                  save('isLogin', false);
              },
            )));
  }
}
