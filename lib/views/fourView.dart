import 'package:flutter/material.dart';
import '../components/list.dart';
import '../views/cardView.dart';
import '../views/deletePage.dart';
import '../views/gridView.dart';
import '../views/studyRowOrColumn.dart';
import '../views/gestureView.dart';
import '../views/changeState.dart';
import '../views/newApp.dart';
import '../redux/cpf_state.dart';
import '../redux/user_redux.dart';
import '../model/user_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../views/loginPage.dart';
import 'package:flutter_app/dao/dao.dart';
import 'package:flutter_app/net/address.dart';

import 'package:dio/dio.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:flutter_app/views/stateManager.dart';
import 'package:flutter_app/views/webView.dart';
import 'package:flutter_app/views/localizaPage.dart';
import 'package:flutter_app/views/savePage.dart';

class TutorialHome extends StatefulWidget {
  @override

  _TutorialHomeState createState() => _TutorialHomeState();
}

class _TutorialHomeState extends State<TutorialHome> {


  @override
  void initState() {
    // TODO: implement initState

//    UserDao.newLogin('15632177857', '123456').then((res){
//      print(res);
//    });
    _getHttp();
    
    super.initState();
  }
  _getHttp()async{
    Dio dio = new Dio();
    Map requestParams = {
      "userName": "15632177857",
      "password": "123456",
      "type": "2",
      "app": "ios",
      "msgid":"",
      "vcode":""

    };
    Response response=await dio.post(Address.getlogion(),data: requestParams);
    print(response.data);
  }

  @override

  var list = ['card','侧滑删除','GridView','如何控制Row/Column','GestureDetector','StatefulWidget改变状态','exampleApp','状态管理',"加载网页","语言国际化","本地化存储"];
  Widget build(BuildContext context) {
    Widget listView = new ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return new ListTile(
            onTap: (){
              if(index==0){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>(new cardPage())));
              }else if (index ==1){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>(new deletePage() )));
              }else if (index ==2){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> (new gridPage())));
              }else if (index ==3){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>(new rowPage())));
              }else if (index ==4){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>(new gesturePage())));
              }else if (index ==5){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>(new changeStatePage())));
              }else if(index ==6){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>(new loginPage())));
              }else if (index ==7){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>(new statePage())));
              }else if (index ==8){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>(new webView())));

              }else if (index ==9){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>(new localizaPage())));
              }else if (index ==10){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>(new savePage())));
              }
            },
            title: new Text(list[index]),
            trailing: new Icon(Icons.home),
            subtitle: new Text('点击进入详情'),

          );
        });

    //Scaffold是Material中主要的布局组件
    return  new Scaffold(
      //appBar用于显示一个应用栏在其Scaffold顶部
      appBar: new AppBar(
        //leading在标题之前显示的组件 IconButton 交互图标
        leading: new IconButton(
          //Icons是一个包含多个可用图标的列表
            icon: new Icon(Icons.menu),
            tooltip: "导航菜单",
            onPressed: null),
        title: new Text("ceshi"),
        //在标题之后显示的组件 注意是数组形式 可以有多个widget
        actions: <Widget>[
          new IconButton(
            //icon：在按钮中显示的图标
              icon: new Icon(Icons.shopping_cart),
              //tooltip:提示信息，当用户长按按钮时将显示此文本
              tooltip: "open shopping cart",
              //点击该按钮时的回调  类似于Andorid的onClick 如果设置为null将禁用该按钮(不妨碍tooltip)
              onPressed: openCart)
        ],
      ),
      //body将占屏幕的大部分 Scaffold中的主要内容
      body: new Center(
        //Center会将其子widget置于其中心位置  这是官方对他的说明 A widget that centers its child within itself.
        child: listView,
//        widthFactor: 5.0,//可以小于1.0但必须是正数 todo 现在这个我也没玩熟 还有待研究
//        heightFactor:50.0,/
      ),

      //FloatingActionButton 浮动按钮 将悬停在内容以上 note:每个页面最多一个浮动按钮 可以用于共享或导航等案例
      //和上面的iconbutton类似 属性就类似了不再做描述 其还有很多属性 比如backgroundColor 可以指定背景颜色 老夫的粉红少女心..
      floatingActionButton: new FloatingActionButton(
        tooltip: "增加",
        child: new Icon(Icons.add),
        onPressed: null,
        backgroundColor: Colors.pink,
      ),
    );
  }

  /**
   * 打开购物车的点击事件回调函数
   */
  void openCart() {
    print("open shopping cart");
  }
}








