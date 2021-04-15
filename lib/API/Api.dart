import 'package:flutter_shop/Net/LSHttpRequestManager.dart';
import 'package:flutter_shop/Business/Login/Model/User.dart';
class Api {
  Future<void> sensSms(String mobile) async {
    print('发送验证码...');
    await Future.delayed(Duration(seconds: 1));
    print('发送验证码成功');
  }

  /// 用户登录。简单起见，返回User
  Future<User> login(String mobile, String sms) async {
    print('登录中...');
    await Future.delayed(Duration(seconds: 1));
    User user = User(1, '程序员磊哥');
    print('登录成功: $user');
    return user;
  }

  Future<Map<String, dynamic>> checkUserExist() {
    return LSHttpRequestManager().post('web-pay/pay/app/checkUserExist',
        pathParams: {}, data: {'operatorId': '0001', 'user': '18300348930'},
        errorCallback: (statusCode) {
      print('Http error code : $statusCode');
    });
  }

  Future<Map<String, dynamic>> requestITCover() {
    return LSHttpRequestManager().get('api/appsplash/get',
        pathParams: {}, data: {},
        errorCallback: (statusCode) {
          print('Http error code : $statusCode');
        });
  }

}
