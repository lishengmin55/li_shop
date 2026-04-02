//管理路由
import 'package:flutter/material.dart';
import 'package:li_shop/pages/Login/index.dart';
import 'package:li_shop/pages/Main/index.dart';

Widget getRootWidget() {
  return MaterialApp(
    title: 'Li Shop',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    ),
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