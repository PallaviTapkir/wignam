import '../../../../../core/api/api_urls.dart';
import '../../../../../core/api/http_helper.dart';
import '../../../../../core/api/network_response.dart';

class LoginRemoteDatasource {
  LoginRemoteDatasource(this.networkHelper);

  final NetworkHelper networkHelper;

  final String _sendLoginOTPUrl = ApiUrl.sendLoginOTP;

  Future<NetworkResponse> sendLoginOTP({
    required final String mobile,
  }) async {
    final Map<String, dynamic> requestBody = {'mobile': mobile};

    final NetworkResponse response = await networkHelper(
      url: _sendLoginOTPUrl,
      type: NetworkCallType.post,
      requestBody: requestBody,
    );

    return response;
  }
}
