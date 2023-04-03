import '../../../../../core/api/api_urls.dart';
import '../../../../../core/api/http_helper.dart';
import '../../../../../core/api/network_response.dart';

class VerifyOTPRemoteDatasource {
  VerifyOTPRemoteDatasource(this.networkHelper);

  final NetworkHelper networkHelper;

  final String verifyOTPUrl = ApiUrl.verifyOTP;

  Future<NetworkResponse> verifyOTP(
      {required final String requestId, required final String otp}) async {
    final Map<String, dynamic> requestBody = {
      'request_id': requestId,
      'code': otp
    };

    final NetworkResponse response = await networkHelper(
      url: verifyOTPUrl,
      type: NetworkCallType.post,
      requestBody: requestBody,
    );

    return response;
  }
}
