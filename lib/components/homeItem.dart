import 'package:flutter/material.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/model/evtent.dart';
import 'package:flutter_app/uniti/event_utils.dart';
class homeItem extends StatelessWidget {
  final evtent evtentModel;
  final VoidCallback onPress;
  final bool needImage;
  homeItem(this.evtentModel,{this.onPress, this.needImage = true}):super();
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

//  var other = EventUtils.getActionAndDes(evtentModel);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:EdgeInsets.all(0),
      child: Card(
        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        color: Colors.white,
        child: new FlatButton(onPressed: onPress,
            child:new Padding(
                padding:EdgeInsets.only(top: 10,bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      FadeInImage(
                        placeholder: AssetImage("images/我的@2x.png"),
                        image: NetworkImage(evtentModel.actor.avatar_url),
                        width: 30.0,
                        height: 30.0,
                      ),
                      Expanded(
                        child: new Text(evtentModel.actor.login),
                      ),
                      new Text(getNewsTimeStr(evtentModel.createdAt)),
                    ],
                  ),
                  new Container(
                    child:Text(EventUtils.getActionAndDes(evtentModel)['actionStr'],style: TextStyle(fontSize: 14),textAlign: TextAlign.left) ,
                    margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                     alignment: Alignment.topLeft,
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
