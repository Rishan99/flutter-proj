import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:moviehub/core/constant/api_url.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/core/routes/routes.dart';
import 'package:moviehub/core/utility/exceptions/exception.dart';
import 'package:moviehub/core/utility/extension.dart';
import 'package:moviehub/services/core/preference_service.dart';
import 'package:flutter/material.dart';

class HttpService {
  final PreferenceService preferenceService;

  HttpService(this.preferenceService) {
    _dio.options = BaseOptions(baseUrl: ApiUrl.baseUrl, headers: {
      'Accept': 'application/json',
    });
  }

  final Dio _dio = Dio()
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        String headers = "";
        options.headers.forEach((key, value) {
          headers += "| $key: $value";
        });
        options.headers.addAll({"Accept": "application/json"});
        debugPrint('--------------------------------');
        debugPrint('Request Path ${options.path}');
        debugPrint('''[DIO] Request: ${options.method} ${options.uri.toString()}
        Request Body: ${(options.data is FormData) ? (options.data as FormData).fields : options.data}
        Headers:\n$headers''');
        debugPrint('--------------------------------');
        handler.next(options);
      },
      onError: (e, handler) async {
        debugPrint('--------------------------------');
        debugPrint('Request Path ${e.requestOptions.path}');
        debugPrint('Parameters ${e.requestOptions.queryParameters}');
        debugPrint("[DIO] Response [code ${e.response?.statusCode}]");
        debugPrint('--------------------------------');
        debugPrint((e.response?.data ?? e.message).toString());
        debugPrint('--------------------------------');
        // if ((e.response?.statusCode == 401 || e.response?.statusCode == 403)) {
        //   if (Routes.loginPage != Get.currentRoute) {
        //     locator<PreferenceService>().clearSession();
        //     Get.offAllNamed(Routes.loginPage);
        //     displayToastFailure("Session Expired, Please Login");
        //   }
        //   handler.reject(e);
        // } else {
        //   handler.next(e);
        // }
        handler.next(e);
      },
      onResponse: (response, handler) async {
        debugPrint('--------------------------------');
        debugPrint('Request Path ${response.requestOptions.path}');
        debugPrint('Parameters ${response.requestOptions.queryParameters}');
        debugPrint("[DIO] Response [code ${response.statusCode}]");
        debugPrint('--------------------------------');
        debugPrint(response.data.toString());
        debugPrint('--------------------------------');
        return handler.next(response);
      },
    ));

  ///GET Request without Authentication header
  Future<dynamic> getRequestWithoutAuth(String url, {dynamic data, Map<String, dynamic>? body}) async {
    _dio.options.contentType = '';
    late Response response;
    _dio.options.headers.remove("contentType");
    _dio.options.headers.remove("content-Type");
    try {
      response = await _dio.get(ApiUrl.baseUrl + url, queryParameters: data, data: body);
    } catch (e) {
      _handleDioError(e);
    }
    if (response.data == null) throw "Error Fetching Data";
    if (!response.statusCode.isSuccessStatusCode()) {
      throw (response.data.toString());
    }
    return response.data;
  }

  ///POST Request without Authentication header
  Future<dynamic> postRequestWithoutAuth(String url, {dynamic data}) async {
    late Response response;
    _dio.options.headers.clear();
    try {
      response = await _dio.post(ApiUrl.baseUrl + url, data: data);
    } catch (e) {
      _handleDioError(e);
    }
    if (response.data == null) throw "Error Fetching Data";
    if (!response.statusCode.isSuccessStatusCode()) {
      throw (response.data.toString());
    }
    return response.data;
  }

  ///POST Request without Authentication header
  Future<dynamic> postFormDataRequestWithoutAuth(String url, {dynamic data}) async {
    _dio.options.contentType = 'multipart/form-data';
    _dio.options.headers.clear();
    late Response response;
    try {
      response = await _dio.post(ApiUrl.baseUrl + url, data: FormData.fromMap(data));
    } catch (e) {
      _handleDioError(e);
    }
    if (response.data == null) throw "Error Fetching Data";
    if (!response.statusCode.isSuccessStatusCode()) {
      throw (response.data.toString());
    }
    return response.data;
  }

  ///GET Request with Authentication header
  Future<dynamic> getData(String url, {Map<String, dynamic>? data, dynamic body}) async {
    String token = preferenceService.accessToken;
    _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    _dio.options.headers.remove("contentType");
    _dio.options.headers.remove("content-Type");
    // .contentType = 'application/json';
    late Response response;
    try {
      response = await _dio.get(ApiUrl.baseUrl + url, queryParameters: data, data: body);
    } catch (e) {
      _handleDioError(e);
    }
    if (response.data == null) throw "Error Fetching Data";
    if (!response.statusCode.isSuccessStatusCode()) {
      if (response.data.runtimeType == Map<String, dynamic>) {
        throw ((response.data['detail'] ?? response.data).toString());
      } else {
        throw (response.data.toString());
      }
    }
    return response.data;
  }

  ///POST Request with UrlEncoded type
  Future<dynamic> postDataUrlEncoded(String url, {dynamic data}) async {
    String token = preferenceService.accessToken;
    _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    _dio.options.contentType = 'application/x-www-form-urlencoded';
    late Response response;
    try {
      response = await _dio.post(ApiUrl.baseUrl + url, data: data);
    } catch (e) {
      _handleDioError(e);
    }
    if (response.data == null) throw "Error Fetching Data";
    if (!response.statusCode.isSuccessStatusCode()) {
      throw (response.data.toString());
    }
    return response.data;
  }

  ///POST Request with JSON Content-Type
  Future<dynamic> postDataJson(
    String url, {
    dynamic data,
    bool sendToken = true,
  }) async {
    if (sendToken) {
      String token = preferenceService.accessToken;
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    } else {
      _dio.options.headers.clear();
    }
    _dio.options.contentType = 'application/json';
    late Response response;
    try {
      response = await _dio.post(
        (ApiUrl.baseUrl) + url,
        data: jsonEncode(data),
      );
    } catch (e) {
      _handleDioError(e);
    }
    if (response.data == null) throw "Error Fetching Data";

    if (response.statusCode.isSuccessStatusCode()) {
      return response.data;
    }
    throw (response.data.toString());
  }

  ///POST Request with JSON Content-Type
  Future<dynamic> putDataJson(String url, {dynamic data, bool sendToken = true}) async {
    if (sendToken) {
      String token = preferenceService.accessToken;
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    } else {
      _dio.options.headers.clear();
    }
    _dio.options.contentType = 'application/json';
    late Response response;
    try {
      response = await _dio.put(
        (ApiUrl.baseUrl) + url,
        data: jsonEncode(data),
      );
    } catch (e) {
      _handleDioError(e);
    }
    if (response.data == null) throw "Error Fetching Data";

    if (response.statusCode.isSuccessStatusCode()) {
      return response.data;
    }
    throw (response.data.toString());
  }

  ///POST Request with Multipart-Form Data Content-Type
  Future<dynamic> postDataFormData(String url, {required dynamic data, bool sendToken = true}) async {
    if (sendToken) {
      String token = preferenceService.accessToken;
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    } else {
      _dio.options.headers.clear();
    }
    _dio.options.contentType = 'multipart/form-data';

    late Response response;
    try {
      response = await _dio.post(ApiUrl.baseUrl + url, data: data.runtimeType == FormData ? data : FormData.fromMap(data));
    } catch (e) {
      _handleDioError(e);
    }
    if (response.data == null) throw "Error Fetching Data";
    if (!response.statusCode.isSuccessStatusCode()) {
      throw (response.data.toString());
    }
    return response.data;
  }

  ///POST Request with Multipart-Form Data Content-Type
  Future<dynamic> putDataFormData(String url, {required dynamic data, bool sendToken = true}) async {
    if (sendToken) {
      String token = preferenceService.accessToken;
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    } else {
      _dio.options.headers.clear();
    }
    _dio.options.contentType = 'multipart/form-data';

    late Response response;
    try {
      response = await _dio.put(ApiUrl.baseUrl + url, data: data.runtimeType == FormData ? data : FormData.fromMap(data));
    } catch (e) {
      _handleDioError(e);
    }
    if (response.data == null) throw "Error Fetching Data";
    if (!response.statusCode.isSuccessStatusCode()) {
      throw (response.data.toString());
    }
    return response.data;
  }

  ///PATCH Request with Multipart-Form Data Content-Type
  Future<dynamic> patchData(String url, {required dynamic data}) async {
    String token = preferenceService.accessToken;
    _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    _dio.options.contentType = 'application/json';

    late Response response;
    try {
      response = await _dio.patch(ApiUrl.baseUrl + url, data: (data));
    } catch (e) {
      _handleDioError(e);
    }
    if (response.data == null) throw "Error Fetching Data";
    if (!response.statusCode.isSuccessStatusCode()) {
      throw (response.data.toString());
    }
    return response.data;
  }

  ///Delete Request with Multipart-Form Data Content-Type
  Future<dynamic> deleteData(String url, {required dynamic data}) async {
    String token = preferenceService.accessToken;
    _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    _dio.options.contentType = 'application/json';

    late Response response;
    try {
      response = await _dio.delete(ApiUrl.baseUrl + url, data: jsonEncode(data));
    } catch (e) {
      _handleDioError(e);
    }
    if (response.data == null) throw "Error Fetching Data";
    if (!response.statusCode.isSuccessStatusCode()) {
      throw (response.data.toString());
    }
    return response.data;
  }

  ///Download File
  Future<String> downloadFile(String url, String savePath) async {
    String token = preferenceService.accessToken;
    _dio.options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      headers: {
        'Authorization': 'Bearer $token',
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=50, max=1000",
      },
    );
    late Response response;
    try {
      response = await _dio
          .download(
            url,
            savePath,
            deleteOnError: true,
          )
          .timeout(const Duration(minutes: 2));
    } catch (e) {
      _handleDioError(e);
    }
    if (!response.statusCode.isSuccessStatusCode()) {
      throw (response.data.toString());
    }
    return savePath;
  }

  _handleDioError(dynamic errors) {
    if (errors.runtimeType == DioException) {
      DioException error = errors;
      if (error.error.runtimeType == SocketException) {
        throw ("Servcer Offline or no internet connection");
      }
      if (error.response?.data == null) {
        throw "Error Fetching Data";
      } else if (error.response?.statusCode == 422) {
        var response = error.response!;
        List<dynamic> parsedMessage = [];
        if (response.data != null && response.data is Map) {
          var data = ((response.data['errors'] ?? {}) as Map).values.fold(
            [],
            (initial, e) {
              initial.addAll((e as List<dynamic>).map((e) => e.toString()));
              return initial;
            },
          );
          parsedMessage.addAll(data);
        }

        String parsedMessageValue = parsedMessage.where((element) => element.trim().isNotEmpty).join("\n");
        if (parsedMessageValue.isEmpty) {
          parsedMessageValue = response.data['message'];
        }
        throw parsedMessageValue;
      }
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          throw ("Connection Timeout");
        case DioExceptionType.sendTimeout:
          throw ("Request Timeout");
        case DioExceptionType.receiveTimeout:
          throw "Response Timeout";
        case DioExceptionType.badResponse:
          if (error.response!.statusCode == 401) {
            throw ("Session Expired");
          } else {
            if (error.response?.data is! String && error.response?.data['error'] != null) throw error.response?.data['error'];
            throw error.response!.data;
          }
        default:
          throw (error.message ?? '');
      }
    }
    throw (errors.toString());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) {
        return true;
      });
  }
}
