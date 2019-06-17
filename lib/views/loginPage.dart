import 'package:flutter/material.dart';
import 'dart:async';
import '../location/locationStore.dart';
import '../config/config.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/user_redux.dart';
import '../components/CPFTextfield.dart';
import '../redux/cpf_state.dart';
import '../components/CPFButtonWidget.dart';
import '../redux/user_redux.dart';
import '../model/user_model.dart';
import '../net/netUtil.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_app/uniti/common_uniti.dart';
import 'package:flutter_app/dao/dao.dart';
import 'package:flutter_app/views/newHomePage.dart';
class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}
class _loginPageState extends State<loginPage> {
  var _userName = '';
  var _passWord = '';
  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwdController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    initparams();
  }

  initparams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _passWord = await LocalStorage.get(Config.PW_KEY);
    userController.value = new TextEditingValue(text: _userName ?? '');
    pwdController.value = new TextEditingValue(text: _passWord ?? '');
  }

  _login(String userName,String pwd)async {
    UserDao.login(userName.trim(), pwd.trim()).then((res) {
      Navigator.pop(context);
        if(res != null && res.result){
          new Future.delayed(const Duration(seconds: 1),(){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>(new appHomePage())));
          });
        }

    }
    );
  }
//padding 内边距
  //marin 外边距
  @override
  Widget build(BuildContext context) {
//    return new StoreBuilder<CPFState>(builder: (context, store) {
      return new Scaffold(
        appBar: AppBar(
          title: new Text('登录'),

        ),
        body: new GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            body: new Container(
              color: Theme
                  .of(context)
                  .primaryColor,
              child: Center(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: new Card(
                      //设置阴影
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Colors.white,
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: new Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 30, right: 30, bottom: 0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Image(
                                image: new AssetImage('images/统计(2)@2x.png'),
                                width: 60,
                                height: 60),
                            new Padding(padding: const EdgeInsets.all(10)),
                            new CPFTextfieldPage(
                              hintText: '请输入帐号',
                              iconData: Icons.home,
                              onChanged: (String value) {
                                _userName = value;
                              },
                              controller: userController,
                            ),
                            new Padding(padding: new EdgeInsets.all(10.0)),
                            new CPFTextfieldPage(
                              hintText: '请输入密码',
                              iconData: Icons.edit,
                              onChanged: (String pwd) {
                                _passWord = pwd;
                              },
                              controller: pwdController,
                            ),
                            new Padding(padding: new EdgeInsets.all(20.0)),
                            CPFButtonWidget(
                              text: '登录',
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              textColor: Colors.white,
                              onPress: () {
                                if (_userName == null || _userName.length == 0) {
                                  return;
                                }
                                if (_passWord == null || _passWord.length == 0) {
                                  return;
                                }
                                CommonUtils.showLoadingDialog(context);
                                _login(_userName,_passWord);

                              },
                            ),
                            new Padding(
                              padding: const EdgeInsets.all(30),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
//    });
  }
}


