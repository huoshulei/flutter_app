import 'package:flutter/material.dart';
import 'package:flutter_app/utils/sp_utils.dart';
import 'package:flutter_app/net/api.dart';
import 'package:flutter_app/bean/user.dart';
import 'package:flutter_app/utils/MD5Utils.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateLogin();
}

class _StateLogin extends State<LoginWidget> {
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _hintFont = TextStyle(color: Colors.black12, fontSize: 15.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
                child: Icon(
                  Icons.close,
                  color: Colors.black45,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                }),
            actions: <Widget>[
              Container(
                  child: GestureDetector(
                      child: Text("注册",
                          style: TextStyle(
                              color: Colors.lightBlue.shade700,
                              fontSize: 15.0)),
                      onTap: () {
//                Navigator.of(context).push(route)
                        print('sadasdsad');
//              TODO  注册
                      }),
                  margin: EdgeInsets.only(right: 15.0),
                  alignment: Alignment.center)
            ],
            elevation: .0,
            backgroundColor: Color(0xffffff)),
        body: ListView(children: <Widget>[
          _userAvatar(),
          Padding(
              padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              child: TextField(
                  controller: _name,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: '请输入您的手机号', hintStyle: _hintFont))),
          Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: TextField(
                  controller: _password,
                  decoration:
                      InputDecoration(hintText: '请输入密码', hintStyle: _hintFont),
                  obscureText: true)),
          Padding(
              padding: EdgeInsets.only(left: 30.0, top: 50.0, right: 30.0),
              child: SizedBox(
                  child: RaisedButton(
                      onPressed: _onLogin,
                      child: Text('登录', style: TextStyle(fontSize: 15.0)),
                      elevation: 12.0,
                      color: Color(0xff1482ff),
                      textColor: Colors.white),
                  height: 50.0)),
          Container(
              child: GestureDetector(
                  onTap: _recover(),
                  child: Text('忘记密码？',
                      style:
                          TextStyle(color: Color(0xff1482ff), fontSize: 15.0))),
              padding: EdgeInsets.only(top: 15.0, right: 30.0),
              alignment: Alignment.centerRight),
          _divider(),
          _otherLogin()
        ]));
  }

  Row _otherLogin() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
        Widget>[
      GestureDetector(
          onTap: _qqLogin(),
          child: Column(children: <Widget>[
            Image.asset('assets/icon/icon_qq.png', width: 55.0, height: 55.0),
            Padding(
                child: Text('QQ登录',
                    style: TextStyle(fontSize: 11.0, color: Color(0xff999999))),
                padding: EdgeInsets.only(top: 9.0))
          ])),
      GestureDetector(
          onTap: _wechatLogin(),
          child: Column(children: <Widget>[
            Image.asset('assets/icon/icon_wechat.png',
                width: 55.0, height: 55.0),
            Padding(
                child: Text('微信登录',
                    style: TextStyle(fontSize: 11.0, color: Color(0xff999999))),
                padding: EdgeInsets.only(top: 9.0))
          ])),
      GestureDetector(
          onTap: _sinaLogin(),
          child: Column(children: <Widget>[
            Image.asset('assets/icon/icon_sina.png', width: 55.0, height: 55.0),
            Padding(
                child: Text('新浪微博',
                    style: TextStyle(fontSize: 11.0, color: Color(0xff999999))),
                padding: EdgeInsets.only(top: 9.0))
          ]))
    ]);
  }

  Container _divider() {
    return Container(
      padding:
          EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0, bottom: 20.0),
      child: Text.rich(TextSpan(text: ' ', children: [
        TextSpan(
            text: '\u3000\u3000\u3000\u3000\u3000\u3000',
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.black26)),
        TextSpan(
            text: '\u3000其他登录方式\u3000',
            style: TextStyle(
              color: Colors.black45,
            )),
        TextSpan(
            text: '\u3000\u3000\u3000\u3000\u3000\u3000',
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.black26)),
        TextSpan(
          text: ' ',
        )
      ])),
      alignment: Alignment.center,
    );
  }

  Center _userAvatar() => Center(
        child: PhysicalModel(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(55.0)),
          elevation: 10.0,
          child: Image.asset(
            'assets/icon/app_logo.png',
            width: 110.0,
            height: 110.0,
          ),
        ),
        heightFactor: 1.20,
      );

  _onLogin() {
    login(Login(_name.text, encrypt(_password.text))).then((loginResponse) {
      token = loginResponse.token;
      userId = loginResponse.userId;
      save('isLogin', true);
      Navigator.of(context).pop();
    });
  }

  _recover() {
//    TODO 忘记密码
  }

  _qqLogin() {}

  _sinaLogin() {}

  _wechatLogin() {}
}
