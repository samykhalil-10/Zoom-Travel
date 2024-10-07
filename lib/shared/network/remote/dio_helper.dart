import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zoom_travel/shared/network/end_points.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    debugPrint('dio helper run');
    dio = Dio(BaseOptions(
      validateStatus: (_) => true,
      baseUrl: ApiUrl.baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData({
    required String url,
    bool containImage = false,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return dio!.post(
      url,
      data: containImage ? FormData.fromMap(data!) : data,
      queryParameters: query,
      options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
  }

  static Future<Response> putData({
    required String url,
    var data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return dio!.put(
      url,
      data: data,
      queryParameters: query,
      options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio!.get(
      url,
      queryParameters: query,
      options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    ).catchError((error) {
      print('This is error :${error.toString()}');
    });
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio!.delete(
      url,
      queryParameters: query,
      data: data,
      options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
  }
}
