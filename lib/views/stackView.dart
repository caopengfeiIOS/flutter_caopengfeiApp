import 'package:flutter/material.dart';
class StackPage extends StatefulWidget {
  @override
  _StackPageState createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  @override
  Widget build(BuildContext context) {
    Widget stack =   new Stack(
      //控制其子项位置
      //alignment: AlignmentDirectional.center,
      //通过绝对坐标来控制子项位置
      alignment: const Alignment(0.0, -0.5),
      children: [
        //圆形图像
        //第一个widget为Base widget 随后的widget将会覆盖在base widget上 位置alignment控制
        new CircleAvatar(
          backgroundColor: Colors.black12,
          backgroundImage: new AssetImage("images/1.png"),
          radius: 100.0,
        ),
        new Container(
          child: new Text(
            "xiaoshuang",
            style: new TextStyle(
                color: Colors.red,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('cpf跳转'),
        ),
        body:stack,
    );


  }
}
