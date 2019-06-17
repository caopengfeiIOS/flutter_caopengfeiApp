import 'package:flutter/material.dart';
import 'package:flutter_app/uniti/cpf_pull_new_load_widget.dart';
import 'dart:async';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_app/generated/translations.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/location/locationStore.dart';
import 'package:flutter_app/config/config.dart';
import 'package:convert/convert.dart';
import 'dart:convert';
import 'package:flutter_app/net/address.dart';
import 'package:flutter_app/net/api.dart';
import 'package:flutter_app/model/evtent.dart';
import 'package:flutter_app/dao/dao.dart';
import 'package:flutter_app/components/homeItem.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_app/uniti/event_utils.dart';
class newAppHome extends StatefulWidget {
  @override
  _newAppHomeState createState() => _newAppHomeState();
}

class _newAppHomeState extends State<newAppHome> with AutomaticKeepAliveClientMixin{
  List<String> addStr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  List<String> str = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  @override
  bool get wantKeepAlive =>true;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
  new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();
  bool _loadMore = true;
  var pageIndex = 1;

  List<evtent> dataList = new List();
  List<evtent> dataSource = new List();
  static final double MILLIS_LIMIT = 1000.0;
  static final double SECONDS_LIMIT = 60 * MILLIS_LIMIT;
  static final double MINUTES_LIMIT = 60 * SECONDS_LIMIT;
  static final double HOURS_LIMIT = 24 * MINUTES_LIMIT;
  static final double DAYS_LIMIT = 30 * HOURS_LIMIT;
  static double sStaticBarHeight = 0.0;
  ///日期格式转换
  static String getNewsTimeStr(DateTime date) {
    int subTime = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if (subTime < MILLIS_LIMIT) {
      return "刚刚";
    } else if (subTime < SECONDS_LIMIT) {
      return (subTime / MILLIS_LIMIT).round().toString() + " 秒前";
    } else if (subTime < MINUTES_LIMIT) {
      return (subTime / SECONDS_LIMIT).round().toString() + " 分钟前";
    } else if (subTime < HOURS_LIMIT) {
      return (subTime / MINUTES_LIMIT).round().toString() + " 小时前";
    } else if (subTime < DAYS_LIMIT) {
      return (subTime / HOURS_LIMIT).round().toString() + " 天前";
    } else {
      return getDateStr(date);
    }
  }
  static String getDateStr(DateTime date) {
    if (date == null || date.toString() == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();

  }
  _loadData() async{

    var userText = await LocalStorage.get(Config.USER_INFO);
    var userMap = json.decode(userText);
    User user = User.fromJson(userMap);
      String url = Address.getEventReceived(user.login) + Address.getPageParams("?", pageIndex);
      var res = await httpManager.netFetch(url, null, null, null);
      if  (res !=null && res.result){
        var data = res.data;
        for (int i=0; i<data.length; i++){

          setState(() {
            dataList.add(evtent.fromJson(data[i]));
           print('7879879889');
           print(dataList.length);
          });
        }
      }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
_print(evtent model){

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: new EasyRefresh(
            key: _easyRefreshKey,
            behavior: ScrollOverBehavior(),
            refreshHeader: ClassicsHeader(
              key: _headerKey,
              refreshText: Translations.of(context).text("pullToRefresh"),
              refreshReadyText: Translations.of(context).text("releaseToRefresh"),
              refreshingText: Translations.of(context).text("refreshing") + "...",
              refreshedText: Translations.of(context).text("refreshed"),
              moreInfo: Translations.of(context).text("updateAt"),
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              moreInfoColor: Colors.black54,
              showMore: true,
            ),
            refreshFooter: ClassicsFooter(
              key: _footerKey,
              loadText: Translations.of(context).text("pushToLoad"),
              loadReadyText: Translations.of(context).text("releaseToLoad"),
              loadingText: Translations.of(context).text("loading"),
              loadedText: Translations.of(context).text("loaded"),
              noMoreText: Translations.of(context).text("noMore"),
              moreInfo: Translations.of(context).text("updateAt"),
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              moreInfoColor: Colors.black54,
              showMore: true,
            ),
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index){
                   var model =dataList[index];
                    return Padding(
                    padding:EdgeInsets.all(0),
                    child: Card(
                      shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      color: Colors.white,
                      child: new FlatButton(onPressed: _print(model),
                          child:new Padding(
                            padding:EdgeInsets.only(top: 10,bottom: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    FadeInImage(
                                      placeholder: AssetImage("images/我的@2x.png"),
                                      image: NetworkImage(model.actor.avatar_url),
                                      width: 30.0,
                                      height: 30.0,
                                    ),
                                    Expanded(
                                      child: new Text(model.actor.login),
                                    ),
                                    new Text(getNewsTimeStr(model.createdAt)),
                                  ],
                                ),
                                new Container(
                                  child:Text(EventUtils.getActionAndDes(model)['actionStr'],style: TextStyle(fontSize: 14),textAlign: TextAlign.left) ,
                                  margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                                  alignment: Alignment.topLeft,
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  );
                },
            ),
            onRefresh: () async {
              await new Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                 dataList.clear();
                 _loadData();
                });
              });
            },
            loadMore: () async {
              await new Future.delayed(const Duration(seconds: 1), () {

                  setState(() {
                    pageIndex = pageIndex+1;
                    _loadData();
                  });

              });
            },

          )),
    );
  }
}
