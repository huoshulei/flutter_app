import 'dart:async';
import 'package:flutter/material.dart';
import '../config/color_config.dart';
import '../widget/banner_widget.dart';
import '../bean/home.dart';
import '../net/api.dart';
import '../utils/sp_utils.dart';

class HomePage extends StatefulWidget {
  var _isNewMessage;
  var _subjectHeight;
  var _bookHeight;
  var _courseHeight;
  final ScrollController _controller;
  final _items;
  final _subjects;
  final _courses;
  final _books;
  var _page;

  HomePage({Key key})
      : _isNewMessage = false,
        _subjectHeight = 180.0,
        _bookHeight = 225.0,
        _courseHeight = 126.0,
        _items = <Information>[],
        _subjects = <Subjects>[],
        _courses = <NetClass>[],
        _books = <Book>[],
        _controller = ScrollController(),
        _page = 1,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _StateHomePage();
}

class _StateHomePage extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._items.clear();
    widget._subjects.clear();
    widget._courses.clear();
    widget._books.clear();
    widget._page = 1;
    widget._controller.addListener(() {
      if (widget._controller.position.pixels ==
          widget._controller.position.maxScrollExtent)
        _loadInformation(widget._page++).then((items) {
          if (mounted)
            setState(() {
              widget._items.addAll(items);
            });
        });
    });
    Future.wait([_loadSubjects(), _loadCourse(), _loadBook()]).then((response) {
      if (mounted)
        setState(() {
          widget._subjects.addAll(response[0]);
          widget._courses.addAll(response[1]);
          widget._books.addAll(response[2]);
          if (widget._subjects.isEmpty) {
            widget._subjectHeight = 0.0;
          } else if (widget._subjects.length <= 4) {
            widget._subjectHeight = 100.0;
          } else if (widget._subjects.length <= 8) {
            widget._subjectHeight = 180.0;
          }
          if (widget._courses.isEmpty) {
            widget._courseHeight = 0.0;
          } else {
            widget._courseHeight = 126.0;
          }
          if (widget._books.isEmpty) {
            widget._bookHeight = 0.0;
          } else {
            widget._bookHeight = 225.0;
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemBuilder: (ctx, i) {
            if (i == 0) return Column(children: children());
            if (i.isOdd) return Divider(height: 0.5);
            var index = i ~/ 2 - 1;
            return _informationItem(widget._items[index]);
          },
          itemCount: widget._items.length * 2 + 1,
          controller: widget._controller,
        ));
  }

  List<Widget> children() {
    return [
      BannerView(
        //banner 图
        data: [
          'http://ww3.sinaimg.cn/large/610dc034jw1fa2vh33em9j20u00zmabz.jpg',
          "http://ww1.sinaimg.cn/large/7a8aed7bgw1eu0w2y0hfbj20hs0qoadi.jpg",
          "http://ww2.sinaimg.cn/large/7a8aed7bjw1f3azi5zoysj20dw0kuabb.jpg",
          "http://ww1.sinaimg.cn/large/610dc034jw1f8rgvvm5htj20u00u0q8s.jpg"
        ],
        buildShowView: (index, data) => Image.network(data,fit: BoxFit.fitWidth,),
        onBannerClickListener: (index, data) {
          Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(data),
              ));
        },
        height: 172.0,
      ),
      Padding(
        padding: EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              //练一练
              child: Card(
                elevation: 4.0,
                child: FlatButton(
                  onPressed: _exercise(),
                  child: Image.asset('assets/icon/icon_exercise.png'),
                  padding: EdgeInsets.only(right: 5.0),
                ),
              ),
            ),
            Expanded(
              //错题本
              child: Card(
                elevation: 4.0,
                child: FlatButton(
                  onPressed: _wrong(),
                  child: Image.asset('assets/icon/icon_wrong.png'),
                  padding: EdgeInsets.only(left: 5.0),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        height: widget._subjectHeight,
        padding: const EdgeInsets.only(
            left: 15.0, top: 20.0, right: 15.0, bottom: 10.0),
        child: Center(
          //科目
          child: _buildSubject(widget._subjects),
        ),
      ),
      _buildCourse(),
      Container(
        height: 5.0,
        color: color_f5f5f5,
      ),
      _buildBook(),
      Container(
        height: 5.0,
        color: color_f5f5f5,
      ),
      Container(
        padding: EdgeInsets.all(15.0),
        child: _title('教育资讯', _moreBook),
      )
    ];
  }

  Container _buildCourse() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          _title('精选课程', _moreBook),
          Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget._courses.length * 2,
              itemBuilder: (context, index) {
                if (index.isOdd)
                  return SizedBox(
                    width: 10.0,
                  );
                else
                  return GestureDetector(
                    onTap: _toCourse(widget._courses[index ~/ 2].key),
                    child: Image.network(
//                                    snapshot.data[index].img == null
//                                        ? 'http://ww3.sinaimg.cn/large/610dc034jw1fa2vh33em9j20u00zmabz.jpg'
//                                        : snapshot.data[index].img,
                      "http://ww4.sinaimg.cn/large/7a8aed7bgw1ewsirtj2efj20k00u0grz.jpg",
                      width: 163.0,
                      height: 102.0,
                    ),
                  );
              },
            ),
            height: widget._courseHeight,
          ),
        ],
      ),
    );
  }

  Container _buildBook() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          _title('精选图书', _moreBook),
          Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget._books.length * 2,
              itemBuilder: (context, index) {
                if (index.isOdd)
                  return SizedBox(
                    width: 10.0,
                  );
                else
                  return GestureDetector(
                    onTap: _toBook(widget._books[index ~/ 2].url),
                    child: Column(
                      children: <Widget>[
                        Image.network(
//                                    snapshot.data[index].img == null
//                                        ? 'http://ww3.sinaimg.cn/large/610dc034jw1fa2vh33em9j20u00zmabz.jpg'
//                                        : snapshot.data[index].img,
                          "http://ww4.sinaimg.cn/large/7a8aed7bgw1ewsirtj2efj20k00u0grz.jpg",
                          width: 123.0,
                          height: 160.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            widget._books[index].url,
                            style:
                                TextStyle(fontSize: 15.0, color: color_1e1e1e),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  );
              },
            ),
            height: widget._bookHeight,
          ),
        ],
      ),
    );
  }

  Widget _title(String title, onTop()) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              color: color_1e1e1e, fontSize: 16.0, fontWeight: FontWeight.w700),
        ),
        Expanded(
          child: Center(),
        ),
        GestureDetector(
          onTap: onTop(),
          child: Text(
            '更多',
            style: TextStyle(color: color_666666, fontSize: 13.0),
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        Image.asset(
          'assets/icon/icon_right.png',
          width: 6.0,
          height: 10.0,
        )
      ],
    );
  }

  Widget _buildSubject(List<Subjects> subjects) {
    return GridView.count(
      primary: false,
//          scrollDirection: Axis.horizontal,
//          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
      crossAxisSpacing: 0.0,
      mainAxisSpacing: 15.0,
      crossAxisCount: 4,
      childAspectRatio: 1.25,
      children: _buildGridTileList(subjects),
    );
  }

  List<Widget> _buildGridTileList(List<Subjects> subjects) {
    return new List<Widget>.generate(subjects.length > 8 ? 8 : subjects.length,
        (int index) => _subjectItem(subjects[index]));
  }

  Widget _subjectItem(Subjects subject) {
    return Column(
      children: <Widget>[
        Image.asset(
          'assets/icon/icon_biological.png',
          width: 39.0,
          height: 39.0,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          subject.name,
          style: TextStyle(fontSize: 12.0),
        )
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: FlatButton.icon(
                onPressed: _search(),
                icon: Icon(
                  Icons.search,
                  color: color_666666,
                  size: 16.0,
                ),
                label: Text(
                  '请输入关键字',
                  style: TextStyle(color: color_666666),
                ),
              ),
            )
          ],
        ),
//        color: Colors.black,
        decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          color: color_eeeeee,
        ),
        height: 27.0,
      ),
      actions: <Widget>[
        IconButton(
          icon: Image.asset(
            'assets/icon/icon_scan.png',
            width: 22.0,
            height: 22.0,
          ),
          onPressed: _scan(),
          alignment: Alignment.center,
          padding: EdgeInsets.all(.0),
        ),
        IconButton(
          onPressed: _message(),
          icon: Image.asset(
            widget._isNewMessage
                ? 'assets/icon/message_seleted.png'
                : 'assets/icon/message_normal.png',
            width: 22.0,
            height: 22.0,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(.0),
        )
      ],
      elevation: .0,
    );
  }

  _search() {
//    TODO 搜索页
  }

  _scan() {
//    Scaffold.of(context).showSnackBar(SnackBar(
//          content: Text('asdasdasd'),
//        ));
  }

  _message() {}

  _wrong() {}

  _exercise() {}

  Future<List<Subjects>> _loadSubjects() async {
    String name = await grade;
    return subjects(name);
  }

  _moreCourse() {
//    TODO 更多坑成
  }

  _moreBook() {}

  Future<List<NetClass>> _loadCourse() async {
    return recommendCourses();
  }

  _toCourse(id) {
//    TODO 网课详情
  }

  _toBook(url) {}

  Future<List<Book>> _loadBook() async {
    return recommendBooks();
  }

  Future<List<Information>> _loadInformation(int page) async {
    return recommendInformation(page);
  }

  Widget _informationItem(Information data) {
    return ListTile(
      onTap: () {
        print(data.title);
      },
      title: Text(data.title),
      subtitle: Text('${data.classifyname}  ${data.pv}阅读'),
      trailing: Image.network(
        "http://ww1.sinaimg.cn/large/7a8aed7bgw1eu0w2y0hfbj20hs0qoadi.jpg",
        width: 94.0,
        height: 59.0,
      ),
      dense: true,
    );
  }
}

//import 'dart:async';
//import 'package:flutter/material.dart';
//import '../config/color_config.dart';
//import '../widget/banner_widget.dart';
//import '../bean/home.dart';
//import '../net/api.dart';
//import '../utils/sp_utils.dart';
//
//class HomePage extends StatefulWidget {
//  var _informations = <Information>[];
//  var _isNewMessage = false;
//  var _subjectHeight = 180.0;
//  var _bookHeight = 225.0;
//  var _courseHeight = 126.0;
//  var _page = 1;
//
//  @override
//  State<StatefulWidget> createState() => _StateHomePage();
//}
//
//class _StateHomePage extends State<HomePage> {
//  var _itemCount = 8;
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//        appBar: _buildAppBar(),
//        backgroundColor: Colors.white,
//        body: FutureBuilder<List<Information>>(
//            future: _loadInformation(widget._page++),
//            builder: (context, snapshot) {
//              switch (snapshot.connectionState) {
//                default:
//                  return ListView.builder(
//                    itemBuilder: (context, index) {
//                      if (index == 0)
//                        return BannerView(
//                          //banner 图
//                          data: [
//                            'http://ww3.sinaimg.cn/large/610dc034jw1fa2vh33em9j20u00zmabz.jpg',
//                            "http://ww1.sinaimg.cn/large/7a8aed7bgw1eu0w2y0hfbj20hs0qoadi.jpg",
//                            "http://ww2.sinaimg.cn/large/7a8aed7bjw1f3azi5zoysj20dw0kuabb.jpg",
//                            "http://ww1.sinaimg.cn/large/610dc034jw1f8rgvvm5htj20u00u0q8s.jpg"
//                          ],
//                          buildShowView: (index, data) => Image.network(data),
//                          onBannerClickListener: (index, data) {
//                            Scaffold.of(context).showSnackBar(SnackBar(
//                                  content: Text(data),
//                                ));
//                          },
//                          height: 172.0,
//                        );
//                      if (index == 1)
//                        return Padding(
//                          padding: EdgeInsets.only(
//                              left: 15.0, top: 15.0, right: 15.0),
//                          child: Row(
//                            children: <Widget>[
//                              Expanded(
//                                //练一练
//                                child: Card(
//                                  elevation: 4.0,
//                                  child: FlatButton(
//                                    onPressed: _exercise(),
//                                    child: Image
//                                        .asset('assets/icon/icon_exercise.png'),
//                                    padding: EdgeInsets.only(right: 5.0),
//                                  ),
//                                ),
//                              ),
//                              Expanded(
//                                //错题本
//                                child: Card(
//                                  elevation: 4.0,
//                                  child: FlatButton(
//                                    onPressed: _wrong(),
//                                    child: Image
//                                        .asset('assets/icon/icon_wrong.png'),
//                                    padding: EdgeInsets.only(left: 5.0),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        );
//                      if (index == 2)
//                        return Container(
//                          height: widget._subjectHeight,
//                          padding: const EdgeInsets.only(
//                              left: 15.0, top: 20.0, right: 15.0, bottom: 10.0),
//                          child: Center(
//                            //科目
//                            child: FutureBuilder<List<Subjects>>(
//                              future: _loadSubjects(),
//                              builder: (context, snapshot) {
//                                switch (snapshot.connectionState) {
//                                  case ConnectionState.waiting:
//                                    return CircularProgressIndicator();
//                                  default:
//                                    if (snapshot.hasData) {
//                                      if (snapshot.data.isEmpty) {
//                                        widget._subjectHeight = 0.0;
//                                      } else if (snapshot.data.length <= 4) {
//                                        widget._subjectHeight = 100.0;
//                                      } else if (snapshot.data.length <= 8) {
//                                        widget._subjectHeight = 180.0;
//                                      }
//                                      if (snapshot.data.length <= 8)
//                                        return _buildSubject(snapshot.data);
//                                      else //分页
//                                        return _buildSubject(snapshot.data);
//                                    } else {
//                                      return Container();
//                                    }
//                                }
//                              },
//                            ),
//                          ),
//                        );
//                      if (index == 3) return _buildCourse();
//                      if (index == 4)
//                        return Container(
//                          height: 5.0,
//                          color: color_f5f5f5,
//                        );
//                      if (index == 5) return _buildBook();
//                      if (index == 6)
//                        return Container(
//                          height: 5.0,
//                          color: color_f5f5f5,
//                        );
//                      if (index == 7) return _buildInformation();
//                      if (snapshot.hasData) {
//                        widget._informations.addAll(snapshot.data);
//                        _itemCount += snapshot.data.length * 2;
//                        if (index.isEven) {
//                          return Divider(
//                            height: 1.0,
//                          );
//                        }
//                        var i = (index - 8) ~/ 2;
//                        if (i >= widget._informations.length) {
//                          _loadInformation(widget._page++).then((items) {
//                            widget._informations.addAll(items);
//                            _itemCount += items.length * 2;
//                          });
//                        }
//                        return _informationItem(widget._informations[i]);
//                      } else {
//                        _itemCount += 2;
//                        return Text("又错了？？？？？？");
//                      }
//                    },
//                    itemCount: _itemCount,
//                  );
//              }
//            }));
//  }
//
//  Container _buildCourse() {
//    return Container(
//      padding: EdgeInsets.all(15.0),
//      child: Column(
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              Text(
//                '精选课程',
//                style: TextStyle(
//                    color: color_1e1e1e,
//                    fontSize: 16.0,
//                    fontWeight: FontWeight.w700),
//              ),
//              Expanded(
//                child: Center(),
//              ),
//              GestureDetector(
//                onTap: _moreCourse(),
//                child: Text(
//                  '更多',
//                  style: TextStyle(color: color_666666, fontSize: 13.0),
//                ),
//              ),
//              SizedBox(
//                width: 5.0,
//              ),
//              Image.asset(
//                'assets/icon/icon_right.png',
//                width: 6.0,
//                height: 10.0,
//              )
//            ],
//          ),
//          Container(
//            padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
//            child: FutureBuilder<List<NetClass>>(
//              future: _loadCourse(),
//              builder: (context, snapshot) {
//                switch (snapshot.connectionState) {
//                  case ConnectionState.waiting:
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                  default:
//                    if (snapshot.hasData) {
//                      if (snapshot.data.isEmpty) {
//                        widget._courseHeight = 0.0;
//                      } else {
//                        widget._courseHeight = 126.0;
//                      }
//                      return ListView.builder(
//                        scrollDirection: Axis.horizontal,
//                        itemCount: snapshot.data.length * 2,
//                        itemBuilder: (context, index) {
//                          if (index.isOdd)
//                            return SizedBox(
//                              width: 10.0,
//                            );
//                          else
//                            return GestureDetector(
//                              onTap: _toCourse(snapshot.data[index ~/ 2].key),
//                              child: Image.network(
////                                    snapshot.data[index].img == null
////                                        ? 'http://ww3.sinaimg.cn/large/610dc034jw1fa2vh33em9j20u00zmabz.jpg'
////                                        : snapshot.data[index].img,
//                                "http://ww4.sinaimg.cn/large/7a8aed7bgw1ewsirtj2efj20k00u0grz.jpg",
//                                width: 163.0,
//                                height: 102.0,
//                              ),
//                            );
//                        },
//                      );
//                    } else {
//                      return MaterialButton(
//                          onPressed: () {
//                            setState(() {});
//                          },
//                          child: Container());
//                    }
//                }
//              },
//            ),
//            height: widget._courseHeight,
//          ),
//        ],
//      ),
//    );
//  }
//
//  Container _buildBook() {
//    return Container(
//      padding: EdgeInsets.all(15.0),
//      child: Column(
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              Text(
//                '精选图书',
//                style: TextStyle(
//                    color: color_1e1e1e,
//                    fontSize: 16.0,
//                    fontWeight: FontWeight.w700),
//              ),
//              Expanded(
//                child: Center(),
//              ),
//              GestureDetector(
//                onTap: _moreBook(),
//                child: Text(
//                  '更多',
//                  style: TextStyle(color: color_666666, fontSize: 13.0),
//                ),
//              ),
//              SizedBox(
//                width: 5.0,
//              ),
//              Image.asset(
//                'assets/icon/icon_right.png',
//                width: 6.0,
//                height: 10.0,
//              )
//            ],
//          ),
//          Container(
//            padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
//            child: FutureBuilder<List<Book>>(
//              future: _loadBook(),
//              builder: (context, snapshot) {
//                switch (snapshot.connectionState) {
//                  case ConnectionState.waiting:
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                  default:
//                    if (snapshot.hasData) {
//                      if (snapshot.data.isEmpty) {
//                        widget._bookHeight = 0.0;
//                      } else {
//                        widget._bookHeight = 225.0;
//                      }
//                      return ListView.builder(
//                        scrollDirection: Axis.horizontal,
//                        itemCount: snapshot.data.length * 2,
//                        itemBuilder: (context, index) {
//                          if (index.isOdd)
//                            return SizedBox(
//                              width: 10.0,
//                            );
//                          else
//                            return GestureDetector(
//                              onTap: _toBook(snapshot.data[index ~/ 2].url),
//                              child: Column(
//                                children: <Widget>[
//                                  Image.network(
////                                    snapshot.data[index].img == null
////                                        ? 'http://ww3.sinaimg.cn/large/610dc034jw1fa2vh33em9j20u00zmabz.jpg'
////                                        : snapshot.data[index].img,
//                                    "http://ww4.sinaimg.cn/large/7a8aed7bgw1ewsirtj2efj20k00u0grz.jpg",
//                                    width: 123.0,
//                                    height: 160.0,
//                                  ),
//                                  Padding(
//                                    padding: EdgeInsets.all(5.0),
//                                    child: Text(
//                                      snapshot.data[index].url,
//                                      style: TextStyle(
//                                          fontSize: 15.0, color: color_1e1e1e),
//                                      maxLines: 2,
//                                      overflow: TextOverflow.ellipsis,
//                                    ),
//                                  )
//                                ],
//                              ),
//                            );
//                        },
//                      );
//                    } else {
//                      return Container();
//                    }
//                }
//              },
//            ),
//            height: widget._bookHeight,
//          ),
//        ],
//      ),
//    );
//  }
//
//  Container _buildInformation() {
//    return Container(
//      padding: EdgeInsets.all(15.0),
//      child: Row(
//        children: <Widget>[
//          Text(
//            '教育资讯',
//            style: TextStyle(
//                color: color_1e1e1e,
//                fontSize: 16.0,
//                fontWeight: FontWeight.w700),
//          ),
//          Expanded(
//            child: Center(),
//          ),
//          GestureDetector(
//            onTap: _moreBook(),
//            child: Text(
//              '更多',
//              style: TextStyle(color: color_666666, fontSize: 13.0),
//            ),
//          ),
//          SizedBox(
//            width: 5.0,
//          ),
//          Image.asset(
//            'assets/icon/icon_right.png',
//            width: 6.0,
//            height: 10.0,
//          )
//        ],
//      ),
//    );
//  }
//
//  Widget _buildSubject(List<Subjects> subjects) {
//    return GridView.count(
//      primary: false,
////          scrollDirection: Axis.horizontal,
////          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
//      crossAxisSpacing: 0.0,
//      mainAxisSpacing: 15.0,
//      crossAxisCount: 4,
//      childAspectRatio: 1.25,
//      children: _buildGridTileList(subjects),
//    );
//  }
//
//  List<Widget> _buildGridTileList(List<Subjects> subjects) {
//    return new List<Widget>.generate(
//        subjects.length, (int index) => _subjectItem(subjects[index]));
//  }
//
//  Widget _subjectItem(Subjects subject) {
//    return Column(
//      children: <Widget>[
//        Image.asset(
//          'assets/icon/icon_biological.png',
//          width: 39.0,
//          height: 39.0,
//        ),
//        SizedBox(
//          height: 8.0,
//        ),
//        Text(
//          subject.name,
//          style: TextStyle(fontSize: 12.0),
//        )
//      ],
//    );
//  }
//
//  AppBar _buildAppBar() {
//    return AppBar(
//      title: Container(
//        child: Row(
//          children: <Widget>[
//            Expanded(
//              child: FlatButton.icon(
//                onPressed: _search(),
//                icon: Icon(
//                  Icons.search,
//                  color: color_666666,
//                  size: 16.0,
//                ),
//                label: Text(
//                  '请输入关键字',
//                  style: TextStyle(color: color_666666),
//                ),
//              ),
//            )
//          ],
//        ),
////        color: Colors.black,
//        decoration: new BoxDecoration(
//          borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
//          color: color_eeeeee,
//        ),
//        height: 27.0,
//      ),
//      actions: <Widget>[
//        IconButton(
//          icon: Image.asset(
//            'assets/icon/icon_scan.png',
//            width: 22.0,
//            height: 22.0,
//          ),
//          onPressed: _scan(),
//          alignment: Alignment.center,
//          padding: EdgeInsets.all(.0),
//        ),
//        IconButton(
//          onPressed: _message(),
//          icon: Image.asset(
//            widget._isNewMessage
//                ? 'assets/icon/message_seleted.png'
//                : 'assets/icon/message_normal.png',
//            width: 22.0,
//            height: 22.0,
//          ),
//          alignment: Alignment.center,
//          padding: EdgeInsets.all(.0),
//        )
//      ],
//      elevation: .0,
//    );
//  }
//
//  _search() {
////    TODO 搜索页
//  }
//
//  _scan() {
////    Scaffold.of(context).showSnackBar(SnackBar(
////          content: Text('asdasdasd'),
////        ));
//  }
//
//  _message() {}
//
//  _wrong() {}
//
//  _exercise() {}
//
//  Future<List<Subjects>> _loadSubjects() async {
//    String name = await grade;
//    return subjects(name);
//  }
//
//  _moreCourse() {
////    TODO 更多坑成
//  }
//
//  _moreBook() {}
//
//  Future<List<NetClass>> _loadCourse() async {
//    return recommendCourses();
//  }
//
//  _toCourse(id) {
////    TODO 网课详情
//  }
//
//  _toBook(url) {}
//
//  Future<List<Book>> _loadBook() async {
//    return recommendBooks();
//  }
//
//  Future<List<Information>> _loadInformation(int page) async {
//    return await recommendInformation(page);
//  }
//
//  Widget _informationItem(Information data) {
//    return Padding(
//      padding: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0, bottom: 5.0),
//      child: ListTile(
//        onTap: () {
//          print(data.title);
//        },
//        title: Text(data.title),
//        subtitle: Text('${data.classifyname}  ${data.pv}阅读'),
//        trailing: Image.network(
//          data.img,
//          width: 94.0,
//          height: 59.0,
//        ),
//        dense: true,
//      ),
//    );
//  }
//}
