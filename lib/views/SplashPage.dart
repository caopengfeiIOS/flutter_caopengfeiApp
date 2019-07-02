import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_app/uniti/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  TimerUtil _timerUtil;
  List<String> _guideList = [
    Utils.getImgPath('6-1'),
    Utils.getImgPath('6-2'),
    Utils.getImgPath('6-3'),
  ];
  List<Widget> _bannerList = new List();
  int _status = 0;
  int _count = 3;



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _initAsync();

  }
  _initAsync() async {
    /// App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();
    Future.delayed(new Duration(milliseconds: 500), () {
      /// 同步使用Sp。
      /// 是否显示引导页。
      if (SpUtil.getBool("key_guide", defValue: true)&& ObjectUtil.isNotEmpty(_guideList)) {
        SpUtil.putBool("key_guide", false);
        _initBanner();
      } else {
        _initSplash();
      }

    });
  }
  /// App引导页逻辑。
  void _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }
  _initBannerData(){
    for (int i=0 ; i < _guideList.length; i++){
      //最后一个
        if(i == _guideList.length - 1){
           _bannerList.add(
             new Stack(
               children: <Widget>[
                 new Image.asset(
                   _guideList[i],
                   fit: BoxFit.fill,
                   width: double.infinity,
                   height: double.infinity,

                 ),
                 new Align(
                   alignment: Alignment.bottomCenter,
                   child: new Container(
                     margin: EdgeInsets.only(bottom: 160),
                     child: new InkWell(
                       onTap: () {
                         _goMain();
                       },
                       child: new CircleAvatar(
                         radius: 48.0,
                         backgroundColor: Colors.indigoAccent,
                         child: new Padding(
                           padding: EdgeInsets.all(2.0),
                           child: new Text(
                             '立即体验',
                             textAlign: TextAlign.center,
                             style: TextStyle(color: Colors.white, fontSize: 16.0),
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
               ],

             ),
           );
        }else{
          _bannerList.add(new Image.asset(
            _guideList[i],
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ));
        }
        }
    }
  void _goMain() {
    Navigator.of(context).pushReplacementNamed('route_main');
  }
  /// App广告页逻辑。
  void _initSplash() {
    setState(() {
      _status = 1;
    });
    _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

Widget _buildAdWidget() {

  return new Offstage(
    offstage: !(_status == 1),
    child: new InkWell(
      onTap: () {

      },
      child: new Container(
        alignment: Alignment.center,
        child: new CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
          imageUrl: '',
          placeholder: (context, url) => _buildSplashBg(),
          errorWidget: (context, url, error) => _buildSplashBg(),
        ),
      ),
    ),
  );
}

  Widget _buildSplashBg() {
    return new Image.asset(
      Utils.getImgPath('750x1334'),
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          ),
          new Offstage(
            offstage: !(_status == 2),
            child: ObjectUtil.isEmpty(_bannerList)
                ? new Container()
                : new Swiper(
                autoStart: false,
                circular: false,
                indicator: CircleSwiperIndicator(
                  radius: 4.0,
                  padding: EdgeInsets.only(bottom: 30.0),
                  itemColor: Colors.black26,
                ),
                children: _bannerList),
          ),
          _buildAdWidget(),
          new Offstage(
            offstage: !(_status == 1),
            child: new Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  _goMain();
                },
                child: new Container(
                    padding: EdgeInsets.all(12.0),
                    child: new Text(
                      '${_count}',
                      style: new TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    decoration: new BoxDecoration(
                        color: Color(0x66000000),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: new Border.all(
                            width: 0.33, color: Colors.red))),
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得中dispose里面把timer cancel。
  }
}
