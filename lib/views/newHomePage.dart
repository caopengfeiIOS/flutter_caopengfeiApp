import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter_app/views/newApphome.dart';
import 'package:flutter_app/views/newAppOrder.dart';
import 'package:flutter_app/views/newAppMine.dart';
class appHomePage extends StatefulWidget {
  @override
  _appHomePageState createState() => _appHomePageState();
}

class _appHomePageState extends State<appHomePage>with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState(){
    controller = new TabController(length: 3, vsync: this);
  }
  /// 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }

    return Future.value(false);
  }
  @override
  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () {
//        return _dialogExitApp(context);
//      },
//      child:



     return  new Scaffold(
        appBar: AppBar(
         title: new Text('测试APP'),

        ),
        bottomNavigationBar: new Material(
          color: Colors.blue,
          child: new TabBar(
              controller: controller,
              tabs:
              <Widget>[
                Tab(icon: Icon(Icons.message), text: '首页',),
                Tab(icon: Icon(Icons.error), text: '消息',),
                Tab(icon: Icon(Icons.home), text: '我的',),

              ]
          ),
        ),
        body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new newAppHome(),
              new newAppOrder(),
              new newAppMine(),

            ]
        ),
      );

  }
}
