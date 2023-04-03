import '../../../../../core/api/network_response.dart';
import '../../../../../core/contracts/repository.dart';

abstract class BaseLoginRepository extends BaseRepository {
  Future<NetworkResponse> sendLoginOTP({
    required final String mobile,
  });
}
