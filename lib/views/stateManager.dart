import 'package:flutter/material.dart';
import 'package:flutter_app/Scoped_model/CountModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/views/stateSecondPage.dart';
class statePage extends StatefulWidget {
  @override
  _statePageState createState() => _statePageState();
}

class _statePageState extends State<statePage> {
  
  @override
  _click(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>(secondState())));
  print('545564546');
  }
  @override
  Widget build(BuildContext context) {
   return ScopedModelDescendant<CountModel>(
     builder: (context,child,model){
       return Scaffold(
         appBar: new AppBar(
           title: new Text('状态管理'),
         ),
         body: Center(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               OutlineButton(
                   onPressed:()=>_click(),
                 child: Text('点击进入下一页'),
               ),
               Text(model.count.toString(),
                 style: TextStyle(fontSize: 48.0,color: Colors.red),
               ),
             ],
           ),
         ),
       );
     },
   );
  }
}
