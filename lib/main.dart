import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:li_shop/routes/index.dart';
import 'package:li_shop/stores/UserStore.dart';
import 'package:li_shop/stores/CartStore.dart';

void main(List<String> args) {
  Get.put(UserStore());
  Get.put(CartStore());
  runApp(getRootWidget());
}