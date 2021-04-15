import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:convert';

class LSHttpRequestMethod {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

class LSHttpRequestManager {
//一个人工智能回答的免费API
  final String _BASEURL = 'https://www.hcharger.com/wx/test/api/';
  //单例模式
  static final LSHttpRequestManager _instance = LSHttpRequestManager._init();
//干活的
  static Dio _dio;

//单例模式，只创建一次实例

// static LSHttpRequestManager getInstance(){
//
//   if (null == _instance){
//     _instance = new LSHttpRequestManager();
//     return _instance;
//   }
//   return _instance;
// }

//  首先，对dio进行初始化。这里使用工厂构造函数创建LSHttpRequestManager，在Dart中，当实现一个使用 factory 关键词修饰的构造函数时，这个构造函数不必创建类的新实例。
  factory LSHttpRequestManager() {
    return _instance;
  }

  LSHttpRequestManager._init() {
    _dio = new Dio();
    _dio.options = _baseOptions;
    //添加拦截器
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
          String url = options.baseUrl + options.path;
          dynamic data = options.data;
      print("在请求之前的拦截信息 +++ url :  $url +++ data : $data");
      return options;
    }, onError: (DioError e) {
      print("在错误之前的拦截信息");
      return e;
    }, onResponse: (Response response) {
      print("在响应之前的拦截信息");
      return response;
    }));
  }

  //配置
  static BaseOptions _baseOptions = getDefOptions();
//设置BaseOptions参数，可以设置网络请求超时时间，设置baseUrl。
// dio默认请求contentType为application/json，如果需要设置为application/x-www-form-urlencoded，需在BaseOptions中单独设置。
// 在BaseOptions.hearders中可以添加自定义的网络请求头信息。

  static BaseOptions getDefOptions() {
    BaseOptions options = BaseOptions();
    options.connectTimeout = 10 * 1000;
    options.receiveTimeout = 20 * 1000;
    options.baseUrl = 'http://dyn.ithome.com/';//'https://www.hcharger.com/wx/test/api/';
    options.contentType =
        Headers.formUrlEncodedContentType;

    Map<String, dynamic> headers = Map<String, dynamic>();
    headers['Accept'] = 'application/json';

    String platform;
    if (Platform.isAndroid) {
      platform = "Android";
    } else if (Platform.isIOS) {
      platform = "IOS";
    }
    headers['OS'] = platform;
    options.headers = headers;

    return options;
  }

  setOptions(BaseOptions options) {
    _baseOptions = options;
    _dio.options = _baseOptions;
  }


//GET请求
  Future<Map<String, dynamic>> get(String path, {pathParams, data, Function errorCallback}) {
    return request(path, method: LSHttpRequestMethod.get, pathParams: pathParams, data: data, errorCallback: errorCallback);
  }
//POST请求
  Future<Map<String, dynamic>> post(String path, {pathParams, data, Function errorCallback}) {
    return request(path, method: LSHttpRequestMethod.post, pathParams: pathParams, data: data, errorCallback: errorCallback);
  }
//  网络请求过程
//
//  path 请求path路径，这里我们进行了restful请求处理，path路径参数放在pathParams中。
//  method 请求方式，可以为GET、POST、PUT、HEAD、DELETE、PATCH等，
//  pathParams path路径参数，Map数据结构
//  errorCallback 自定义错误处理，代码中_handleHttpError()方法进行统一的http错误码处理，如接口需单独处理某种错误码，可添加此回调方法。
  Future<Map<String, dynamic>> request(String path,{String method, Map pathParams, data, Function errorCallback}) async {
    ///restful请求处理
    ///拼接参数
    if(pathParams != null) {
      pathParams.forEach((key, value) {
        if(path.indexOf(key) != -1) {
          path = path.replaceAll(":$key", value.toString());
        }
      });
    }

    Response response = await _dio.request(path, data: data, options: Options(method: method));

    if(response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
      try {
        //  返回数据如果为Map数据直接返回，如果为Json数据需通过json.decode解析之后再返回
        if(response.data is Map) {
          return response.data;
        } else if(response.data is List){
          return {"data":response.data};
        } else {
          return json.decode(response.data.toString());
        }
      } catch(e) {
        print('------------------------request exception: $e------------------');
        formatError(e);
        return null;
      }
    } else {
      _handleHttpError(response.statusCode);
      if(errorCallback != null) {
        errorCallback(response.statusCode);
      }
      return null;
    }
  }

  ///处理Http错误码
  void _handleHttpError(int errorCode) {

    print("LSHttpRequestManager  处理Http错误码 ：$errorCode");

  }
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      print("LSHttpRequestManager  formatError ：连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      print("LSHttpRequestManager  formatError ：请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      print("LSHttpRequestManager  formatError ：响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      print("LSHttpRequestManager  formatError ：出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      print("LSHttpRequestManager  formatError ：请求取消");
    } else {
      print("LSHttpRequestManager  formatError： 未知错误");
    }
  }
}
