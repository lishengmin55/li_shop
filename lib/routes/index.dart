//管理路由
import 'package:flutter/material.dart';
import 'package:li_shop/pages/Login/index.dart';
import 'package:li_shop/pages/Main/index.dart';

//
Widget getRootWidget() {
  return MaterialApp(
    initialRoute: '/',
    routes: getRootRoutes(),
  );
}

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    '/': (context) => MainPage(),
    '/login': (context) => LoginPage(),
  };
}