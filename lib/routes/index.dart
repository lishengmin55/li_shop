//管理路由
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:li_shop/pages/Login/index.dart';
import 'package:li_shop/pages/Register/index.dart';
import 'package:li_shop/pages/Main/index.dart';
import 'package:li_shop/stores/UserStore.dart';

Widget getRootWidget() {
  return GetMaterialApp(
    title: 'Li Shop',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    ),
    home: SplashPage(),
    routes: getRootRoutes(),
  );
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await userStore.init();
    if (userStore.isLoggedIn) {
      Get.offAll(() => MainPage());
    } else {
      Get.offAll(() => LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {'/login': (context) => LoginPage()};
}
