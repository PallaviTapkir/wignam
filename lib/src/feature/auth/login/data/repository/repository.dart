import '../../../../../core/api/network_response.dart';
import '../../domain/repository/repository.dart';
import '../datasource/remote_datasource.dart';

class LoginRepository extends BaseLoginRepository {
  LoginRepository(this.remoteDatasource);

  final LoginRemoteDatasource remoteDatasource;

  @override
  Future<NetworkResponse> sendLoginOTP({
    required String mobile,
  }) async {
    final response = await remoteDatasource.sendLoginOTP(mobile: mobile);
    return response;
  }
}
