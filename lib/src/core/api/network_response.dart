import 'dart:convert';

import 'base_network_response.dart';

class NetworkResponse extends BaseNetworkResponse {
  NetworkResponse({
    required final bool status,
    String? requestId,
    bool? profileExists,
    String? jwt,
  }) : super(
            status: status,
            requestId: requestId,
            profileExists: profileExists,
            jwt: jwt);

  factory NetworkResponse.fromJson(String data) {
    final jsonData = jsonDecode(data);
    return NetworkResponse(
      status: jsonData['status'] as bool,
      requestId: jsonData['request_id'] != null
          ? jsonData['request_id'] as String
          : '',
      profileExists: jsonData['profile_exists'] != null
          ? jsonData['profile_exists'] as bool
          : false,
      jwt: jsonData['jwt'] != null ? jsonData['jwt'] as String : '',
    );
  }
}
