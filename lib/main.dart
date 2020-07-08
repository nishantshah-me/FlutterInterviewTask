import 'package:flutter/material.dart';
import 'data/di/factory.dart';
import 'presentation/routes.dart';

setupLocator() {
  ObjectFactory.register();
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router.generateRoute,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color.fromRGBO(34, 180, 91, 1),
          accentColor: Color.fromRGBO(34, 180, 91, 1),
        ));
  }
}
