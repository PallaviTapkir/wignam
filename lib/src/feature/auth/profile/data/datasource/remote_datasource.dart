import '../../../../../core/api/api_urls.dart';
import '../../../../../core/api/http_helper.dart';
import '../../../../../core/api/network_response.dart';

class SubmitProfileRemoteDatasource {
  SubmitProfileRemoteDatasource(this.networkHelper);

  final NetworkHelper networkHelper;

  final String profileSubmitUrl = ApiUrl.profileSubmit;

  Future<NetworkResponse> submitUserProfile(
      {required final String name,
      required final String email,
      required final String jwtToken}) async {
    final Map<String, dynamic> requestBody = {'name': name, 'email': email};

    final NetworkResponse response = await networkHelper(
        url: profileSubmitUrl,
        type: NetworkCallType.post,
        requestBody: requestBody,
        addToken: true,
        jwtToken: jwtToken);

    return response;
  }
}
