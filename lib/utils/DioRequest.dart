//基于Dio进行二次封装
import 'package:dio/dio.dart';
import 'package:li_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio();
  DioRequest() {
    _dio.options.baseUrl = GlobalConstants.BASE_URL;
    _dio.options.connectTimeout = Duration(seconds: GlobalConstants.TIMEOUT);
    _dio.options.sendTimeout = Duration(seconds: GlobalConstants.TIMEOUT);
    _dio.options.receiveTimeout = Duration(seconds: GlobalConstants.TIMEOUT);
    // 添加拦截器
    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          handler.next(request);
        },
        onResponse: (response, handler) {
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          } else {
            // 处理非成功状态码
            handler.reject(
              DioException(requestOptions: response.requestOptions),
            );
          }
        },
        onError: (error, handler) {
          handler.reject(error);
        },
      ),
    );
  }


  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
    
  }
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task ) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if(data["code"] == GlobalConstants.SUCCESS_CODE){
        return data["result"];
      }
      throw Exception(data["msg"] ?? "请求失败");
    } catch (e) {
      throw Exception(e);
    }
  }
}


final dioRequest = DioRequest();
