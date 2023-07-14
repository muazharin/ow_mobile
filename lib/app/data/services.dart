import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:our_wallet/app/data/constant.dart';
import 'package:our_wallet/app/data/widgets/snackbar_custom.dart';
import 'package:our_wallet/app/routes/app_pages.dart';

final dio = Dio(
  BaseOptions(
      // baseUrl: 'http://192.168.1.21:8080/v1',
      baseUrl: '$baseUrl/v1',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        "X-API-KEY": "d934019a-7ea4-4be5-b413-707ea6d60643",
      }),
);

String error(DioException v, void Function() onTap, {bool? isShow = true}) {
  switch (v.type) {
    case DioExceptionType.connectionTimeout:
      return rto;
    case DioExceptionType.badResponse:
      if (v.response != null) {
        if ("${jsonDecode(v.response!.toString())['message']}"
            .contains("Unauthenticated")) {
          var box = GetStorage();
          box.remove("data");
          box.remove("is_login");
          Get.offAllNamed(Routes.AUTH_LOGIN);
        }
        return "${jsonDecode(v.response!.toString())['message']}";
      } else {
        print(v.message);
        return "${v.message}";
      }
    case DioExceptionType.unknown:
    case DioExceptionType.connectionError:
      // if (isShow!) {
      //   Get.back();
      //   snackbarDanger(message: "Maaf, perangkat tidak terkoneksi internet");
      // }
      return noInternet;
    default:
      return unknown;
  }
}

class APIService {
  var box = GetStorage();
  Future get({
    String? path,
    Map<String, dynamic>? queryParameters,
    required void Function()? onTap,
  }) async {
    try {
      final response = await dio.get(path!, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw error(e, onTap!);
    }
  }

  Future getToken({
    String? path,
    Map<String, dynamic>? queryParameters,
    required void Function()? onTap,
    bool? isShow = true,
  }) async {
    try {
      final response = await dio.get(
        path!,
        queryParameters: queryParameters,
        options: Options(
          headers: {"Authorization": "Bearer ${box.read('token')}"},
        ),
      );
      return response;
    } on DioException catch (e) {
      throw error(e, onTap!, isShow: isShow);
    }
  }

  Future post({
    String? path,
    Object? data,
    required void Function()? onTap,
  }) async {
    try {
      final response = await dio.post(path!, data: data);
      return response;
    } on DioException catch (e) {
      throw error(e, onTap!);
    }
  }

  Future postToken({
    String? path,
    Object? data,
    required void Function()? onTap,
  }) async {
    try {
      final response = await dio.post(
        path!,
        data: data,
        options: Options(
          headers: {"Authorization": "Bearer ${box.read('token')}"},
        ),
      );
      return response;
    } on DioException catch (e) {
      print(e);
      throw error(e, onTap!);
    }
  }

  Future postFileToken({
    String? path,
    FormData? data,
    required void Function()? onTap,
  }) async {
    try {
      final response = await dio.post(
        path!,
        data: data,
        options: Options(
          headers: {"Authorization": "Bearer ${box.read('token')}"},
          contentType: Headers.multipartFormDataContentType,
        ),
      );
      return response;
    } on DioException catch (e) {
      throw error(e, onTap!);
    }
  }

  Future put({
    String? path,
    Object? data,
    required void Function()? onTap,
  }) async {
    try {
      final response = await dio.put(path!, data: data);
      return response;
    } on DioException catch (e) {
      throw error(e, onTap!);
    }
  }

  Future putToken({
    String? path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    required void Function()? onTap,
  }) async {
    print(box.read('token'));
    try {
      final response = await dio.put(
        path!,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {"Authorization": "Bearer ${box.read('token')}"},
        ),
      );
      return response;
    } on DioException catch (e) {
      print(e);
      throw error(e, onTap!);
    }
  }

  Future putFileToken({
    String? path,
    FormData? data,
    required void Function()? onTap,
  }) async {
    try {
      final response = await dio.put(
        path!,
        data: data,
        options: Options(
          headers: {"Authorization": "Bearer ${box.read('token')}"},
          contentType: Headers.multipartFormDataContentType,
        ),
      );
      return response;
    } on DioException catch (e) {
      throw error(e, onTap!);
    }
  }
}
