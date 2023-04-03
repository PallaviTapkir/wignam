import '../../../../../core/api/network_response.dart';
import '../../../../../core/contracts/repository.dart';

abstract class BaseVerifyOTPRepository extends BaseRepository {
  Future<NetworkResponse> verifyOTP({
    required final String requestId,
    required final String otp
  });
}
