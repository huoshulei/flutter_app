import 'package:flutter/material.dart';
import '../config/color_config.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateMine();
}

class _StateMine extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/icon/user_avatar.png',
                    image:
                        'http://ww1.sinaimg.cn/large/0065oQSqly1frrifts8l5j30j60ojq6u.jpg',
                    fit: BoxFit.fill,
                    width: 70.0,
                    height: 70.0,
                  ),
                ),
                Expanded(
                  child: Column(),
                ),
                Image.asset(
                  'assets/icon/icon_right.png',
                  width: 6.0,
                  height: 10.0,
                )
              ],
            ))

//        ListTile(
//          leading: CircleAvatar(
//            backgroundImage: AssetImage(),
//          ),
//          trailing: Icon(Icons.chevron_right),
//        ),
      ],
    );
  }
}
