import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'network_response.dart';

enum NetworkCallType { get, post, put }

class NetworkHelper {
  NetworkHelper._internal() {
    _dio = Dio();
  }

  static final NetworkHelper _instance = NetworkHelper._internal();

  static NetworkHelper get instance => _instance;

  factory NetworkHelper() => _instance;

  static late final Dio _dio;

  static const Map<String, String> _headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  ///This method [_validateStatus] always returns true so that dio returns data for any http status code
  static bool _validateStatus(_) => true;
  static const bool _receiveDataWhenStatusError = true;

  Future<NetworkResponse> call({
    required final String url,
    required final NetworkCallType type,
    final Map<String, dynamic> requestBody = const {},
    final bool useSecureHttp = true,
    final bool addToken = false,
    final String jwtToken = '',
  }) async {
    final Map<String, String> headers = Map.from(_headers);
    if (addToken) {
      log('Using token: $jwtToken');
      headers.addEntries(
          [MapEntry(HttpHeaders.authorizationHeader, 'Token: $jwtToken')]);
    }
    print('Request for $url:$requestBody');

    late final Response httpResponse;

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    switch (type) {
      case NetworkCallType.get:
        httpResponse = await _dio.get(
          url,
          queryParameters: requestBody,
          options: Options(
              headers: headers,
              receiveDataWhenStatusError: _receiveDataWhenStatusError,
              validateStatus: _validateStatus,
              sendTimeout: 20000,
              receiveTimeout: 60000),
        );
        break;

      case NetworkCallType.post:
        httpResponse = await _dio.post(
          url,
          data: requestBody,
          options: Options(
              headers: headers,
              receiveDataWhenStatusError: _receiveDataWhenStatusError,
              validateStatus: _validateStatus,
              sendTimeout: 20000,
              receiveTimeout: 60000),
        );
        break;

      case NetworkCallType.put:
        httpResponse = await _dio.put(
          url,
          data: requestBody,
          onReceiveProgress: (num1, num2) {
            log('Received $num1 our of $num2');
          },
          options: Options(
              headers: headers,
              receiveDataWhenStatusError: _receiveDataWhenStatusError,
              validateStatus: _validateStatus,
              sendTimeout: 20000,
              receiveTimeout: 60000),
        );
        break;

      default:
        throw Exception(
         'This network call type `$type` is not supported',
        );
    }

    final dynamic rawResponse = httpResponse.data;

    print('Response for $url:$rawResponse');

    final NetworkResponse response =
        NetworkResponse.fromJson(rawResponse.toString());
    return response;
  }
}
