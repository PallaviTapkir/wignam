import '../../../../../core/api/network_response.dart';
import '../../../../../core/contracts/repository.dart';

abstract class BaseSubmitProfileRepository extends BaseRepository {
  Future<NetworkResponse> submitUserProfile({
    required final String name,
    required final String email,
    required final String jwtToken
  });
}
