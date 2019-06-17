import 'package:flutter/material.dart';
import 'package:flutter_app/Scoped_model/CountModel.dart';
import 'package:scoped_model/scoped_model.dart';
class secondState extends StatefulWidget {
  @override
  _secondStateState createState() => _secondStateState();
}

class _secondStateState extends State<secondState> {
  @override
  _add(CountModel model){
     model.increment();
  }
  
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CountModel>(
        builder:(context,child,model){
          return Scaffold(
            appBar: AppBar(
              title:new Text('测试状态管理'),
            ),
            body: Center(
              child: IconButton(
                  icon:Icon(Icons.add), 
                  onPressed:()=>_add(model),
              ),
            ),
          );
        },
    );
  }
}
