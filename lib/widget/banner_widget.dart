import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void OnBannerClickListener(int index, dynamic itemData);
typedef Widget BuildShowView(int index, dynamic itemData);

const IntegerMax = 0x7fffffff;

class BannerView extends StatefulWidget {
  final OnBannerClickListener onBannerClickListener;

  //延迟多少秒进入下一页
  final int delayTime; //秒
  //滑动需要秒数
  final int scrollTime; //毫秒
  final double height;
  final List data;
  final BuildShowView buildShowView;

  BannerView(
      {Key key,
      @required this.data,
      @required this.buildShowView,
      this.onBannerClickListener,
      this.delayTime = 3,
      this.scrollTime = 200,
      this.height = 200.0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new BannerViewState();
}

class BannerViewState extends State<BannerView> {
//  double.infinity
  final pageController = new PageController();
  Timer timer;

  BannerViewState() {
//    print(widget.delayTime);
  }

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  resetTimer() {
    clearTimer();
    timer = new Timer.periodic(new Duration(seconds: widget.delayTime),
        (Timer timer) {
      if (pageController.positions.isNotEmpty) {
        var i = pageController.page.toInt() + 1;
        pageController.animateToPage(i == widget.data.length ? 0 : i,
            duration: new Duration(milliseconds: widget.scrollTime),
            curve: Curves.linear);
      }
    });
  }

  clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
//    double screenWidth = MediaQueryData
//        .fromWindow(ui.window)
//        .size
//        .width;
    return new SizedBox(
        height: widget.height,
        child: widget.data.length == 0
            ? null
            : Stack(
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      widget.onBannerClickListener(
                          pageController.page.round() % widget.data.length,
                          widget.data[pageController.page.round() %
                              widget.data.length]);
                    },
                    onTapDown: (details) {
                      clearTimer();
                    },
                    onTapUp: (details) {
                      resetTimer();
                    },
                    onTapCancel: () {
                      resetTimer();
                    },
                    child: new PageView.builder(
                      controller: pageController,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return widget.buildShowView(
                            index, widget.data[index % widget.data.length]);
                      },
                      itemCount: widget.data.length,
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
//                    left: 0.0,
                    child: new Container(
                      // color: Colors.grey[800].withOpacity(0.5),
                      padding: const EdgeInsets.all(15.0),
                      child: DotsIndicator(
                        controller: pageController,
                        itemCount: widget.data.length,
                        color: Colors.black12,
                        onPageSelected: (int page) {
                          pageController.animateToPage(
                            page,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ));
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  static const double _kDotSize = 5.0;
  static const double _kMaxZoom = 2.0;
  static const double _kDotSpacing = 15.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Material(
        color: color,
        type: MaterialType.circle,
        child: new Container(
          width: _kDotSize * zoom,
          height: _kDotSize * zoom,
          child: new InkWell(
            onTap: () => onPageSelected(index),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
