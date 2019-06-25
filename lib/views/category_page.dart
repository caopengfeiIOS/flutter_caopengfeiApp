import 'package:flutter/material.dart';
import 'package:flutter_app/net/service_method.dart';
import 'dart:convert';

class category extends StatefulWidget {
  @override
  _categoryState createState() => _categoryState();
}

class _categoryState extends State<category> {
  String homePageContent = '正在获取数据';

  @override
  void initState() {
    _getCategory();
    super.initState();
  }
  //得到后台大类数据
  void _getCategory() async {
    await request('wxmini/getCategory').then((val) {
      var data = json.decode(val.toString());



      setState(() {
        homePageContent = val.toString();
        print("1111+${homePageContent}");
      });



      //print(list[0].bxMallSubDto);

      //list[0].bxMallSubDto.forEach((item) => print(item.mallSubName));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(homePageContent),
    );
  }
}
