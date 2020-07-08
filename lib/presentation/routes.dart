import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login/login_page.dart';
import 'map/map.dart';

class Router {
  static const String LOGIN = "/";
  static const String LANDING = "/landing";
  static const String MAP = "/map";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case LOGIN:
        return MaterialPageRoute(builder: (_) => MyAppLoginPage());
        break;
      case MAP:
        return MaterialPageRoute(builder: (_) => MapPage());
        break;
      default:
        return MaterialPageRoute(builder: (_) => MyAppLoginPage());
        break;
    }
  }
}
