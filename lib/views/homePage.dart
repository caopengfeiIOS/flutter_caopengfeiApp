import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../views/progress_hud.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  ProgressHUD _progressHUD;
  bool _loading = true;
  @override
  void initState() {
    super.initState();

    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Colors.blue,
      borderRadius: 5.0,
      text: 'Loading...',
    );
  }

  @override
  printStr(){
    print('点击了到达');
  }
  tapClick(){
    showModalBottomSheet(
       context: context,
        builder: (BuildContext context){
         return   new Container(
           height: 200,
           child: Center(
             child: new Text('点击弹窗',style: TextStyle(fontSize: 20,color: Colors.red),),
           ),
         );
        },
    );
  }
  Widget getFenshu(number,title){
    return new GestureDetector(
      onTap: ()=>tapClick(),
      child:  Padding(padding:
      EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(number,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(245, 98, 5, 1),
                fontSize: 20,
              ),
            ),
            Padding(
              padding:EdgeInsets.only(top: 10),
              child: new Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

            ),

          ],
        ),
      ),
    );
  }
  companyClick(index){
    showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
      return new AlertDialog(
        title: new Text('提示'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text('这是点击了$index的内容'),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: new Text('确定')),
        ],
      );
        
      
      }
       
    
    );
  }
  getCompanyList(number,title,index){
    return GestureDetector(
      onTap: ()=>companyClick(index),
      child: Padding(
        padding:EdgeInsets.only(top: 17,bottom: 17),
        child: Container(
          width: (MediaQuery.of(context).size.width-32-20)/4,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(41, 135, 250, 1),
                  fontSize: 16,
                ),
              ),
              Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(41, 135, 250, 1),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }
  shangmenCllick(int index){
    print('点击了$index');
  }
  getShangmen(number,title,index){
    return GestureDetector(
      onTap: ()=>shangmenCllick(index),
      child: Container(
        width: (MediaQuery.of(context).size.width)/4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(number,style: TextStyle(fontSize: 20,color: Colors.red),),
            Text(title,style: TextStyle(fontSize: 18,color: Colors.grey),),
          ],
        ),
      ),
    );
  }
  codeClick(){
    dismissProgressHUD();
  }
  void dismissProgressHUD() {
    setState(() {
      if (_loading) {
        _progressHUD.state.dismiss();
      } else {
        _progressHUD.state.show();
      }

      _loading = !_loading;
    });
  }
  Widget build(BuildContext context) {



    return Scaffold(
//      appBar: AppBar(
//        title: new Text('早餐颂'),
//        actions: <Widget>[
//          FlatButton(
//            child: Text('未到达',
//                textAlign: TextAlign.center,
//                style: TextStyle(color: Colors.white,fontSize:15.0)
//            ),
//            onPressed: printStr(),
//            color: Colors.white10,
//          ),

//        ],
//        automaticallyImplyLeading: true,
//        leading: new Text('国际企业中心',
//          textAlign: TextAlign.center,
//        ),
//      ) ,
      body: new EasyRefresh(
        refreshHeader: ClassicsHeader(
          key: _headerKey,
        ),
        refreshFooter: ClassicsFooter(
          key: _footerKey,
        ),
        key: _easyRefreshKey,
          onRefresh: () async{

          },
          loadMore: () async {

          },

          child:new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding:EdgeInsets.only(top: 16,left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image(image: AssetImage('images/统计(2)@2x.png'),

                      ),
                      Padding(
                        padding:EdgeInsets.only(left: 5),
                        child: new Text('今日套餐',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding:EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      getFenshu('0份', "总分数"),
                      getFenshu('0份', "已取餐"),
                      getFenshu('0份', "剩余"),
                      getFenshu('0份', "已过期"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  height: 120,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Image(image: AssetImage('images/qiyetuancan@2x.png'),
                        width: 20,
                        height: 100,
                        fit: BoxFit.cover,

                      ),
                      Stack(
                        children: <Widget>[
                          Image(image: AssetImage('images/bg@2x.png'),
                            width:MediaQuery.of(context).size.width-32-20,
                            height: 100,
                            fit: BoxFit.cover,

                          ),
                          Positioned(
                            top: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                getCompanyList('0份', '总分数', '1'),
                                getCompanyList('0份', '总分数', '2'),
                                getCompanyList('0份', '总分数', '3'),
                                getCompanyList('0份', '总分数', '4'),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,

                ),

                Container(
                  width: MediaQuery.of(context).size.width,

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:EdgeInsets.only(top: 16,left: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image(image: AssetImage('images/订单_@2x.png')),
                            Padding(padding: EdgeInsets.only(left: 10,

                            ),
                              child:  Text('上门套餐',
                                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontSize: 16),

                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(padding:EdgeInsets.only(top: 30,bottom: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            getShangmen('0份', "总分数", 1),
                            getShangmen('0份', "总分数", 2),
                            getShangmen('0份', "总分数", 3),
                            getShangmen('0份', "总分数", 4),

                          ],
                        ),
                      ),


                    ],
                  ),
                ),
                Container(
                  height: 120,
                  color: Color.fromRGBO(242, 242, 242, 1),
                  child: GestureDetector(
                    onTap: ()=>codeClick(),
                    child: Center(
                      child: Image(image: AssetImage('images/saomian@2x.png'),
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

      ),
    );
  }
}
