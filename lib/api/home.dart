//封装api,返回banner列表
import 'package:li_shop/constants/index.dart';
import 'package:li_shop/utils/DioRequest.dart';
import 'package:li_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerList() async {
  final result = await dioRequest.get(HttpConstants.BANNER_LIST);
  // print(result);
  return (result as List).map((e) => BannerItem.fromJson(e)).toList();
}

Future<List<CategoryItem>> getCategoryList() async {
  final result = await dioRequest.get(HttpConstants.CATEGORY_LIST);
  // print(result);
  return (result as List).map((e) => CategoryItem.fromJson(e)).toList();
}

Future<HomeRecommendResult> getHomeRecommend() async {
  final result = await dioRequest.get(HttpConstants.SUGGESTION_LIST);
  return HomeRecommendResult.fromJson(result);
}

Future<HomeRecommendResult> getInVogueList() async {
  final result = await dioRequest.get(HttpConstants.IN_VOGUE_LIST);
  return HomeRecommendResult.fromJson(result);
}

Future<HomeRecommendResult> getOneStopList() async {
  final result = await dioRequest.get(HttpConstants.ONE_STOP_LIST);
  return HomeRecommendResult.fromJson(result);
}

Future<List<GoodDetailItem>> getRecommend({
  Map<String, dynamic> param = const {'limit': 20},
}) async {
  final result = await dioRequest.get(
    HttpConstants.RECOMMEND_LIST,
    params: param,
  );
  return (result as List).map((e) => GoodDetailItem.formJSON(e)).toList();
}
