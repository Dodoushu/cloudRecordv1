import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'showAlertDialogClass.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'globalConfig.dart';
import 'resultCode.dart';
import 'showToast.dart';

/*
 * 网络请求管理类
 */
class DioManager {
  //写一个单例
  //在 Dart 里，带下划线开头的变量是私有变量
  static DioManager _instance;

  static DioManager getInstance() {
    if (_instance == null) {
      _instance = DioManager();
    }
    return _instance;
  }

  Dio dio = new Dio();
  DioManager() {
    // Set default configs
//    dio.options.headers = {
//      "version": '2.0.9',
//    };
    dio.options.baseUrl = "http://39.100.100.198:8082/";
    dio.options.connectTimeout = 50000;
    dio.options.receiveTimeout = 30000;

    dio.interceptors
        .add(LogInterceptor(responseBody: GlobalConfig.isDebug)); //是否开启请求日志
    dio.interceptors.add(CookieManager(CookieJar())); //缓存相关类
  }

  //get请求
  get(String url, Map params, Function successCallBack,
      Function errorCallBack) async {
    _requstHttp(url, successCallBack, 'get', params, errorCallBack);
  }

  String _contentType;
  //post请求
  post(String url, params, Function successCallBack,
      Function errorCallBack,{String ContentType = 'application/json'}) async {
    _contentType = ContentType;
    _requstHttp(url, successCallBack, "post", params, errorCallBack);
  }

  _requstHttp(String url, Function successCallBack,
      [String method, params, Function errorCallBack]) async {
    Response response;
    try {
      if (method == 'get') {
        if (params != null && params.length > 0) {
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
      } else if (method == 'post') {
        if (params != null && params.length > 0) {
          if(_contentType == 'multipart/form-data'){
            dio.options.contentType = 'multipart/form-data';
          }
          response = await dio.post(url, data: params);
          dio.options.contentType = 'application/json';
        } else {
          response = await dio.post(url);
        }
      }
    } on DioError catch (error) {
      // 请求错误处理
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      // 请求超时
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = ResultCode.CONNECT_TIMEOUT;
      }
      // 一般服务器错误
      else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = ResultCode.RECEIVE_TIMEOUT;
      }

      // debug模式才打印
      if (GlobalConfig.isDebug) {
        print('请求异常: ' + error.toString());
        print('请求异常url: ' + url);
        print('请求头: ' + dio.options.headers.toString());
        print('method: ' + dio.options.method);
      }
      _error(errorCallBack, error.message);
      return '';
    }
    // debug模式打印相关数据
    if (GlobalConfig.isDebug) {
      print('请求url: ' + url);
      print('请求头: ' + dio.options.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
    }
    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap == null || dataMap['state'] == 0) {
      _error(
          errorCallBack,
          '错误码：' +
              dataMap['errorCode'].toString() +
              '，' +
              response.data.toString());
    } else if (successCallBack != null) {
      successCallBack(dataMap);
    }
  }

  _error(Function errorCallBack, String error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }
}


//老版封装
Future request(url, BuildContext context,
    {FormData, String contentType = 'application/json'}) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = contentType;

    showDialog(
        //loading动画
        context: context,
        builder: (context) {
          return new NetLoadingDialog();
        });
    // FormData是数据体，默认放在post中的body里
    response = await dio.post(url, data: FormData);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print('http成功');
      Navigator.of(context).pop(); //成功，退出loading动画
      return response;
    } else {
      //Loading.complete();
      //throw Exception('网络异常');
    }
  } catch (e) {
    print(e);

//    showAlertDialog(context, titleText: '请求失败', contentText: '请稍后重试',flag: 1);  //失败，点击退出失败提示弹窗和loading动画
  }
}
