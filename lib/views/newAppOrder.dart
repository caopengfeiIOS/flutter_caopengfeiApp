import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_app/generated/translations.dart';
import 'package:async/async.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_app/Application/Application.dart';
import 'package:flutter_app/views/webView.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_app/model/DetailsModel.dart';
import 'package:flutter_html/flutter_html.dart';
class newAppOrder extends StatefulWidget {
  @override
  _newAppOrderState createState() => _newAppOrderState();
}

class _newAppOrderState extends State<newAppOrder> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive =>true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
  new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();
  var pageIndex = 1;
  bool _loadMore = true;
  List<Map> hotGoodsList=[];


  @override
  _request()async{
    Response response;
    var formData = {'lon':'115.02932','lat':'35.76189'};
    Dio dio = new Dio();
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    response = await dio.post('http://v.jspang.com:8088/baixing/wxmini/homePageContent',data:formData);

    if(response.data.length > 4000) {
      for(int i=0;i<response.data.length;i+=4000){
        if(i+4000<response.data.length)
          print(response.data.substring(i, i+4000));
        else
          print(response.data.substring(i,response.data.length));
      }
    } else{

    }
    return response.data;
  }
  _loadHtoGoods()async{
    Response response;
    var formPage={'page': pageIndex};
    Dio dio = new Dio();
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    response = await dio.post('http://v.jspang.com:8088/baixing/wxmini/homePageBelowConten',data:formPage);
    print('11111+${response.data}');
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    super.build(context);
    return FutureBuilder(
      future: _request(),
      builder: (context,dataSource){
        if(dataSource.hasData){
          var data=json.decode(dataSource.data.toString());
          List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 顶部轮播组件数
          List<Map> navigatorList =(data['data']['category'] as List).cast(); //类别列表
          String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
          String  leaderImage= data['data']['shopInfo']['leaderImage'];  //店长图片
          String  leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话
          List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐
          String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
          String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
          String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
          List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片
          List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层1商品和图片
          List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层1商品和图片
          return new EasyRefresh(
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
              noMoreText:  Translations.of(context).text(_loadMore ? 'loadFinish' : 'noMore'),
              moreInfo: Translations.of(context).text("updateAt"),
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              moreInfoColor: Colors.black54,
              showMore: true,
            ),
            child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDataList:swiperDataList),
                  TopNavigator(navigatorList:navigatorList),
                  AdBanner(advertesPicture:advertesPicture),
                  LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone),  //广告组件
                  Recommend(recommendList:recommendList),// 商品推荐
                  FloorTitle(picture_address:floor1Title),//楼层1的标题
                  FloorContent(floorGoodsList:floor1),//楼层1的内容
                  FloorTitle(picture_address:floor2Title),
                  FloorContent(floorGoodsList:floor2),
                  FloorTitle(picture_address:floor3Title),
                  FloorContent(floorGoodsList:floor3),
                  _hotGoods(),
                ],
            ),

            onRefresh: () async{

              setState(() {
                _request();
              });

            },
            loadMore: ()async {
              if(pageIndex==3){
                _easyRefreshKey.currentState.waitState(() {
                  setState(() {
                    _loadMore = false;
                  });
                });
              }else{
                _loadHtoGoods().then((value){
                  var data=json.decode(value.toString());
                  List<Map> newGoodsList = (data['data'] as List ).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    pageIndex++;
                  });
                });
              }
              }


          );
        }else{
          return Center(
            child: Text('加载中'),

          );
        }



      },

    );
  }


  //火爆专区标题
  Widget hotTitle= Container(
    margin: EdgeInsets.only(top: 10.0),

    padding:EdgeInsets.all(5.0),
    alignment:Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        border:Border(
            bottom: BorderSide(width:0.5 ,color:Colors.black12)
        )
    ),
    child: Text('火爆专区'),
  );


  //火爆专区子项
  Widget _wrapList(){

    if(hotGoodsList.length!=0){
      List<Widget> listWidget = hotGoodsList.map((val){

        return InkWell(
            onTap:(){

              Application.router.navigateTo(context,"/detail?id=${val['goodsId']}");
            },
            child:
            Container(
              width: ScreenUtil().setWidth(372),
              color:Colors.white,
              padding: EdgeInsets.all(5.0),
              margin:EdgeInsets.only(bottom:3.0),
              child: Column(
                children: <Widget>[
                  Image.network(val['image'],width: ScreenUtil().setWidth(375),),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis ,
                    style: TextStyle(color:Colors.pink,fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),

                      )
                    ],
                  )
                ],
              ),
            )

        );

      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }else{
      return Text(' ');
    }
  }
//火爆专区组合
  Widget _hotGoods(){

    return Container(

        child:Column(
          children: <Widget>[
            hotTitle,
            _wrapList(),
          ],
        )
    );
  }

}


// 首页轮播组件编写
class SwiperDiy extends StatelessWidget{
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      width: ScreenUtil.getInstance().width,
      height: 200,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return InkWell(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>(new DetailsPage(goodsId : swiperDataList[index]['goodsId'],))));

            },
            child:  Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill),
          );

        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//首页导航组件
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);
  Widget _gridViewItemUI(BuildContext context,item,index){
    // print('------------------${item}');
    return InkWell(
      onTap: (){
        _goCategory(context,index,item);
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  void _goCategory(context,int index,Map map) async {
    showToast("点击了第${index}个种类为${map['mallCategoryName']}");
  }

  @override
  Widget build(BuildContext context) {

    if(navigatorList.length>10){
      navigatorList.removeRange(10, navigatorList.length);
    }
    var tempIndex=-1;
    return Container(
      color:Colors.white,
      margin: EdgeInsets.only(top: 5.0),
      height: ScreenUtil().setHeight(300),
      padding:EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item){
          tempIndex++;
          return _gridViewItemUI(context, item,tempIndex);

        }).toList(),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  final String advertesPicture;
  AdBanner({Key key,this.advertesPicture}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      color: Colors.white,
      child: Image.network(advertesPicture),
    );
  }
}
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;
  LeaderPhone ({Key key,this.leaderImage,this.leaderPhone}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchUrl,
        child: Image.network(leaderImage),
      ),
    );
  }
  _launchUrl()async{
    String url = 'tel:' + leaderPhone;
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'could not launch $url';
    }
  }
}

class Recommend  extends StatelessWidget {
  final List recommendList;
  Recommend({Key key,this.recommendList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommedList(context)
        ],

      ),

    );
  }
  _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12)
        )
      ),
      child: Text('商品推荐',style: TextStyle(color: Colors.pink),),

    );
  }
  _recommedList(BuildContext contex) {
    return Container(
      height: ScreenUtil().setHeight(380),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context , index){
            return _item(index,context);
          }
      ),
    );

   }
   _item(int index,BuildContext context){
     return InkWell(
       onTap: (){
         showToast('点击了第${index}个');
       },
       child: Container(

         width: ScreenUtil().setWidth(280),
         padding: EdgeInsets.all(8.0),
         decoration:BoxDecoration(
             color:Colors.white,
             border:Border(
                 left: BorderSide(width:0.5,color:Colors.black12)
             )
         ),
         child: Column(
           children: <Widget>[
             Image.network(recommendList[index]['image']),
             Text('￥${recommendList[index]['mallPrice']}'),
             Text(
               '￥${recommendList[index]['price']}',
               style: TextStyle(
                   decoration: TextDecoration.lineThrough,
                   color:Colors.grey
               ),
             )
           ],
         ),
       ),
     );
   }
}

class FloorTitle extends StatelessWidget {
  final String picture_address;
  FloorTitle({Key key,this.picture_address}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}

class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  FloorContent({Key key,this.floorGoodsList}): super(key : key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context)
        ],
      ),

    );
  }
  Widget _firstRow(context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context,floorGoodsList[1]),
            _goodsItem(context,floorGoodsList[2]),
          ],
        )
      ],
    );
  }
  Widget _goodsItem(context,Map goods){

    return Container(
      width:ScreenUtil().setWidth(375),
      child: InkWell(
        onTap:(){
          Application.router.navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child: Image.network(goods['image']),
      ),
    );
  }
  Widget _otherGoods(context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[3]),
        _goodsItem(context,floorGoodsList[4]),
      ],
    );
  }
}

class DetailsWeb extends StatelessWidget {
  final DetailsModel goodsInfo;
  DetailsWeb ({Key key,this.goodsInfo}) : super(key : key);




  @override


  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Html(
          data:goodsInfo.data.goodInfo.goodsDetail
      ),
    );

  }
}

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage({Key key,this.goodsId}) : super(key : key);
  DetailsModel goodsInfo =null;
  Future _getBackInfo(BuildContext context )async{
    Response response;
    Dio dio = new Dio();
    var formData =  {'goodId':goodsId,};
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    response = await dio.post('http://v.jspang.com:8088/baixing/wxmini/getGoodDetailById',data:formData);
    return response.data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:Icon(Icons.arrow_back),
            onPressed: (){
              print('返回上一页');
              Navigator.pop(context);
            },
          ),
          title: Text('商品详细页'),
        ),
        body:FutureBuilder(
            future: _getBackInfo(context) ,
            builder: (context,snapshot){
              if(snapshot.hasData){
                var responseData= json.decode(snapshot.data.toString());
                goodsInfo=DetailsModel.fromJson(responseData);
                var goodsDetail = goodsInfo.data.goodInfo.goodsDetail;
                return Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
//                        DetailsTopArea(),
//                        DetailsExplain(),
//                        DetailsTabBar(),
                        DetailsWeb(goodsInfo:goodsInfo),


                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          child: new Text('底部'),
                        ),
                    )
                  ],
                );




              }else{
                return Text('加载中........');
              }
            }
        )
    );
  }
}

