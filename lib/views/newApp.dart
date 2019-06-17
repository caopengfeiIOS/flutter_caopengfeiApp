import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_custom_bottom_tab_bar/tabbar.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import '../views/homePage.dart';
import '../views/talkPage.dart';
import '../views/orderPage.dart';
import '../views/minePage.dart';
class newAppPage extends StatefulWidget {
  @override

  _newAppPageState createState() => _newAppPageState();
}

class _newAppPageState extends State<newAppPage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  int _selectedIndex = 0;
  String badgeNo1;
  var titles = ['首页','会话','消息','我的'];
  var icons = [
    Icons.home,
    Icons.play_arrow,
    Icons.child_friendly,
    Icons.fiber_new,
  ];
  @override
  void initState(){
    super.initState();
    _tabController = new TabController(length: titles.length, vsync: this,initialIndex: 0);
    badgeNo1 = '12';
  }

  


  @override
  Widget build(BuildContext context) {

    void _onItemSelected(int index) {
      setState(() {
        _selectedIndex = index;
        badgeNo1 = '';
      });
    }
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
      print("liucheng-> ${_tabController.indexIsChanging}");
    });

    return  Scaffold(
      appBar: AppBar(
        title: new Text('早餐颂'),
      ) ,
      bottomNavigationBar: Container(
        height: 46,
        child: Column(
          children: <Widget>[
            Divider(
              height: 2,
            ),
            new TabBar(
              isScrollable: false,
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.red,
              labelPadding: EdgeInsets.all(0),
              unselectedLabelColor: Colors.black,
              tabs: <Widget>[
                EachTab(
                    width: 70,
                    badgeNo: '12',
                    badgeColor: Colors.red,
                    height: 40,
                    padding: EdgeInsets.all(0),
                    icon: _selectedIndex == 0
                        ? Image.asset(
                      'images/首页_pre@2x.png',
                      width: 20,
                      height: 20,
                    )
                        : Image.asset(
                      'images/首页@2x.png',
                      width: 20,
                      height: 20,
                    ),
                    text: titles[0],
                    iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                    textStyle: TextStyle(fontSize: 10)),
                EachTab(
                    height: 40,
                    padding: EdgeInsets.all(0),
                    icon: _selectedIndex == 1
                        ? Image.asset(
                      'images/会话pre@2x.png',
                      width: 20,
                      height: 20,
                    )
                        : Image.asset(
                      'images/会话@2x.png',
                      width: 20,
                      height: 20,
                    ),
                    text: titles[1],
                    iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                    textStyle: TextStyle(fontSize: 10)),
                EachTab(
                    height: 40,
                    padding: EdgeInsets.all(0),
                    icon: _selectedIndex == 2
                        ? Image.asset(
                      'images/会话pre@2x.png',
                      width: 20,
                      height: 20,
                    )
                        : Image.asset(
                      'images/会话@2x.png',
                      width: 20,
                      height: 20,
                    ),
                    text: titles[2],
                    iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                    textStyle: TextStyle(fontSize: 10)),
                EachTab(
                    height: 40,
                    padding: EdgeInsets.all(0),
                    icon: _selectedIndex == 3
                        ? Image.asset(
                      'images/我的_pre@2x.png',
                      width: 20,
                      height: 20,
                    )
                        : Image.asset(
                      'images/我的@2x.png',
                      width: 20,
                      height: 20,
                    ),
                    text: titles[3],
                    iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                    textStyle: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
      body: new TabBarView(
          controller: _tabController,
          children: <Widget>[
            new homePage(),
            new talkPage(),
            new orderPage(),
            new minePage(),
          ]
      ),
    );


  }
}
