import 'package:flutter/material.dart';

class gesturePage extends StatefulWidget {
  @override
  _gesturePageState createState() => _gesturePageState();
}

class _gesturePageState extends State<gesturePage> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        
      },
      onDoubleTap: (){
        print('双击');
      },
      onLongPress: (){
        print('长按');
      },
      child: new Container(
        height: 80.0,
        padding: const EdgeInsets.only(top: 100.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(20.0),
          color: Colors.white,
          
        ),
        child: new Center(child:  new Text('点击监听'),),
      ),
    );
    
    
  }
}

