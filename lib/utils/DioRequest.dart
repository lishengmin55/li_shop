//基于Dio进行二次封装
import 'package:dio/dio.dart';
import 'package:li_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio();
  DioRequest(){
    _dio.options.baseUrl = GlobalConstants.BASE_URL;
    _dio.options.connectTimeout = Duration(seconds: GlobalConstants.TIMEOUT);
    _dio.options.sendTimeout = Duration(seconds: GlobalConstants.TIMEOUT);
    _dio.options.receiveTimeout = Duration(seconds: GlobalConstants.TIMEOUT);
    // 添加拦截器
    _addInterceptors();
  }
  
  void _addInterceptors(){
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 请求拦截器
        print('请求URL: ${options.uri}');
        print('请求方法: ${options.method}');
        print('请求头: ${options.headers}');
        if (options.data != null) {
          print('请求参数: ${options.data}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // 响应拦截器
        print('响应状态码: ${response.statusCode}');
        print('响应数据: ${response.data}');
        
        if(response.statusCode! >= 200 && response.statusCode! < 300){
          return handler.next(response);
        } else {
          // 处理非成功状态码
          return handler.reject(DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: '服务器返回错误: ${response.statusCode}',
          ));
        }
      },
      onError: (error, handler) {
        // 错误拦截器
        String errorMessage = '';
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
            errorMessage = '连接超时';
            break;
          case DioExceptionType.sendTimeout:
            errorMessage = '发送超时';
            break;
          case DioExceptionType.receiveTimeout:
            errorMessage = '接收超时';
            break;
          case DioExceptionType.badResponse:
            errorMessage = '服务器异常: ${error.response?.statusCode}';
            break;
          case DioExceptionType.cancel:
            errorMessage = '请求已被取消';
            break;
          default:
            errorMessage = '网络请求失败';
            break;
        }
        
        // 创建新的 DioException 实例，包含修改后的错误信息
        return handler.next(DioException(
          requestOptions: error.requestOptions,
          response: error.response,
          type: error.type,
          error: errorMessage,
        ));
      },
    ));
  }

  // GET 请求
  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(path, queryParameters: params);
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  // POST 请求
  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.post(path, data: data, queryParameters: params);
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  // PUT 请求
  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.put(path, data: data, queryParameters: params);
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  // DELETE 请求
  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.delete(path, data: data, queryParameters: params);
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }
}

final dioRequest = DioRequest();