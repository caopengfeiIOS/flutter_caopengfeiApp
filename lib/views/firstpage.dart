import 'package:flutter/material.dart';
import '../components/list.dart';
import '../views/stackView.dart';
class FirstPage extends StatefulWidget{
  final String text;
  FirstPage(this.text);
  @override
  FirstPageState createState() => new FirstPageState(text);
  
  
}
class FirstPageState extends State<FirstPage>with AutomaticKeepAliveClientMixin{
  String text;
  FirstPageState(this.text);
 @override
 bool get wantKeepAlive => true;

  @override
  /*初始化状态的方法只运行一次*/
  void initState(){
    super.initState();
    new Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        text = '改变了状态';
      });
    });
  }
@override
void dispose(){
    super.dispose();
}
@override
void didChangeDependencies(){
    super.didChangeDependencies();
}
   getBottomItem (IconData icon, String text){
     ///充满 Row 横向的布局
     return new Expanded(
       ///居中显示
       child: new Center(
         ///横向布局
         child: new Row(
           ///主轴居中,即是横向居中
           mainAxisAlignment: MainAxisAlignment.center,
           ///大小按照最大充满
           mainAxisSize : MainAxisSize.max,
           ///竖向也居中
           crossAxisAlignment : CrossAxisAlignment.center,
           children: <Widget>[
             ///一个图标，大小16.0，灰色
             new Icon(
               icon,
               size: 16.0,
               color: Colors.grey,
             ),
             ///间隔
             new Padding(padding: new EdgeInsets.only(left:5.0)),
             ///显示文本
             new Text(
               text,
               //设置字体样式：颜色灰色，字体大小14.0
               style: new TextStyle(color: Colors.grey, fontSize: 14.0),
               //超过的省略为...显示
               overflow: TextOverflow.ellipsis,
               //最长一行
               maxLines: 1,
             ),
           ],
         ),
       ),
     );
}
void printSome(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
      StackPage()
    ));
}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(text??'没有改变状态'),
          
        ),
      body: new Container(
        child: new Card(

          child: new FlatButton(onPressed: printSome,
              child:
              new Padding(padding:
              new EdgeInsets.only(left: 0,top: 10,right: 10.0,bottom: 10.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Container(
                      child: new Text(
                        '这是一点描述',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      margin: new EdgeInsets.only(top: 10.0,bottom: 3.0),
                      alignment: Alignment.topLeft,
                    ),
                    new Padding(padding:
                      new EdgeInsets.all(10.0),
                    ),
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        getBottomItem(Icons.star, '102333'),
                        getBottomItem(Icons.home, 'fasfa'),
                        getBottomItem(Icons.cloud, '20000'),
                      ],
                    )
                  ],
                ),
              ),

          ),

        ),
      )
      );
  }
}