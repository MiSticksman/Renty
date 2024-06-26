import 'package:client/common/values/constant.dart';
import 'package:client/global.dart';
import 'package:dio/dio.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  late Dio dio;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: {},
      contentType: "application/json: charset=utf-8",
      responseType: ResponseType.json,
    );
    dio = Dio(options);
  }

  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    var response = dio.get(
      path,
      queryParameters: queryParameters,
      options: getOptions(null),
    );
    return response;
  }

  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters = null,
      Options? options = null}) async {
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: getOptions(options),
    );
    return response.statusCode;
  }

  Future postWithResponse(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters = null,
      Options? options = null}) async {
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: getOptions(options),
    );
    return response;
  }

  Future patch(String path, dynamic data,
      {Map<String, dynamic>? queryParameters = null,
      Options? options = null}) async {
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: getOptions(options),
    );
    return response.statusCode;
  }

  Future patchWithResponse(String path, dynamic data,
      {Map<String, dynamic>? queryParameters = null,
      Options? options = null}) async {
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: getOptions(options),
    );
    return response;
  }

  Future delete(String path, dynamic data,
      {Map<String, dynamic>? queryParameters = null,
      Options? options = null}) async {
    var response = await dio.delete(path,
        data: data,
        queryParameters: queryParameters,
        options: getOptions(options));
    return response.statusCode;
  }

  Options getOptions(Options? options) {
    var headers = <String, dynamic>{};
    if (options != null && options.headers != null) {
      headers.addAll(options.headers!);
    }
    if (Global.storageService.isUserAuthenticated()) {
      headers['Authorization'] = Global.storageService.getUser()!.token;
    }
    headers['Content-Type'] = 'application/json';
    return Options(headers: headers);
  }
}
