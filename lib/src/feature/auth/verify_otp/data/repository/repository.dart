import '../../../../../core/api/network_response.dart';
import '../../domain/repository/repository.dart';
import '../datasource/remote_datasource.dart';

class VerifyOTPRepository extends BaseVerifyOTPRepository {
  VerifyOTPRepository(this.remoteDatasource);

  final VerifyOTPRemoteDatasource remoteDatasource;

  @override
  Future<NetworkResponse> verifyOTP(
      {required String requestId, required String otp}) async {
    final response =
        await remoteDatasource.verifyOTP(otp: otp, requestId: requestId);
    return response;
  }
}
