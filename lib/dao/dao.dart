import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/config/config.dart';
import 'package:flutter_app/location/locationStore.dart';
import 'package:flutter_app/net/api.dart';
import 'package:flutter_app/net/address.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/net/result_data.dart';
import 'package:flutter_app/dao/dao_result.dart';
import 'package:flutter_app/model/user_model.dart';
class UserDao {
  static login(userName, password) async {
    String type = userName + ":" + password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);
    if (Config.DEBUG) {
      print("base64Str login " + base64Str);
    }
    await LocalStorage.save(Config.USER_NAME_KEY, userName);
    await LocalStorage.save(Config.USER_BASIC_CODE, base64Str);
    Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": Config.CLIENT_ID,
      "client_secret": Config.CLIENT_SECRET
    };
    httpManager.clearAuthorization();
    var res = await httpManager.netFetch(Address.getAuthorization(), json.encode(requestParams), null, new Options(method: "post"));
    var resultData = null;
    if (res != null && res.result) {
      await LocalStorage.save(Config.PW_KEY, password);
      var resultData = await getUserInfo(null);
      if (Config.DEBUG) {
        print("user result " + resultData.result.toString());
        print(resultData.data);
        print(res.data.toString());
      }
    }
    return new DataResult(resultData, res.result);
  }


  static newLogin(userName,password)async{
    Map parms = {
      "userName":userName,
      "password":password,
      "type":"2",
      "app":"ios"
    };
    var res = await httpManager.netFetch(Address.getlogion(), json.encode(parms), null, new Options(method: "post"));
    return new  DataResult(res, res.result);

  }

  ///获取用户详细信息
  static getUserInfo(userName, {needDb = false}) async {

      var res;
      if (userName == null) {
        res =
        await httpManager.netFetch(Address.getMyUserInfo(), null, null, null);
      } else {
        res = await httpManager.netFetch(
            Address.getUserInfo(userName), null, null, null);
      }
      if (res != null && res.result) {
        String starred = "---";
        if (res.data["type"] != "Organization") {
          var countRes = await getUserStaredCountNet(res.data["login"]);
          if (countRes.result) {
            starred = countRes.data;
          }
        }
        User user = User.fromJson(res.data);
        user.starred = starred;
        LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
        return new DataResult(user, true);
      } else {
        return new DataResult(res.data, false);
      }
  }
    /**
     * 在header中提起stared count
     */
    static  getUserStaredCountNet(userName) async {
      String url = Address.userStar(userName, null) + "&per_page=1";
      var res = await httpManager.netFetch(url, null, null, null);
      if (res != null && res.result && res.headers != null) {
        try {
          List<String> link = res.headers['link'];
          if (link != null) {
            int indexStart = link[0].lastIndexOf("page=") + 5;
            int indexEnd = link[0].lastIndexOf(">");
            if (indexStart >= 0 && indexEnd >= 0) {
              String count = link[0].substring(indexStart, indexEnd);
              return new DataResult(count, true);
            }
          }
        } catch (e) {
          print(e);
        }
      }
      return new DataResult(null, false);
    }

  ///获取本地登录用户信息
  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return new DataResult(user, true);
    } else {
      return new DataResult(null, false);
    }
  }
}