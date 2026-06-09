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
          handler.next(response);
        },
        onError: (error, handler) {
          // 从响应体中提取后端返回的错误信息
          if (error.response?.data != null) {
            try {
              final data = error.response!.data;
              if (data is Map<String, dynamic> && data.containsKey('msg')) {
                handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    message: data['msg'],
                  ),
                );
                return;
              }
            } catch (_) {}
          }
          handler.reject(error);
        },
      ),
    );
  }


  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }

  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        return data["result"];
      }
      throw Exception(data["msg"] ?? "请求失败");
    } on DioException catch (e) {
      final msg = e.message ?? e.response?.statusMessage ?? '请求失败';
      throw Exception(msg);
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}


final dioRequest = DioRequest();
