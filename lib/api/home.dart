//封装api,返回banner列表
import 'package:li_shop/constants/index.dart';
import 'package:li_shop/utils/DioRequest.dart';
import 'package:li_shop/viewmodels/home.dart';


Future<List<BannerItem>> getBannerList() async {
  final result = await dioRequest.get(HttpConstants.BANNER_LIST);
  // print(result);
  return (result as List).map((e) => BannerItem.fromJson(e)).toList();
}