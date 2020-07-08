import 'package:ePaisa_interview/data/model/app_result.dart';
import 'package:ePaisa_interview/domain/entities/login.dart';
import 'package:ePaisa_interview/domain/entities/order.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'Datasource.dart';
import 'dart:convert' as JSON;

class RemoteDatasource extends Datasource {
  Future<AppResult<Order>> fetchOrder() async {
    return AppResult.success(
        Order(1, "Nish", "KFC", 19.1974269, 72.8427441, 19.212084, 72.840849));
  }

  Future<AppResult<LoginEntity>> fetchLoginResponse() async {
    var profile;
    var status = false;
    final facebookLogin = FacebookLogin();
    final facebookLoginResult = await facebookLogin.logIn(['email', 'public_profile']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        status = false;
        var error = facebookLoginResult.errorMessage;
        print(error);
        break;
      case FacebookLoginStatus.cancelledByUser:
        status = false;
        print("CancelledByUser");
        break;
      case FacebookLoginStatus.loggedIn:
        status = true;
        final FacebookAccessToken accessToken = facebookLoginResult.accessToken;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$accessToken');
        profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        break;
    }

    return AppResult.success(LoginEntity(status, profile));
  }

  Future<AppResult<NotificationEntity>> fetchNotificationResponse() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    var title;
    var body;
    var sucess = false;

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];

        title = notification['title'];
        body = notification['body'];
        sucess = true;
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];

        title = notification['title'];
        body = notification['body'];
        sucess = true;
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //return AppResult.success(NotificationEntity(notification['title'], notification['body']));
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    return AppResult.success(NotificationEntity(title, body, sucess));
  }


}
