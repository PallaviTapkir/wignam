import '../../../../../core/api/network_response.dart';
import '../../domain/repository/repository.dart';
import '../datasource/remote_datasource.dart';

class SubmitProfileRepository extends BaseSubmitProfileRepository {
  SubmitProfileRepository(this.remoteDatasource);

  final SubmitProfileRemoteDatasource remoteDatasource;

  @override
  Future<NetworkResponse> submitUserProfile(
      {required String name,
      required String email,
      required String jwtToken}) async {
    final response = await remoteDatasource.submitUserProfile(
        name: name, email: email, jwtToken: jwtToken);
    return response;
  }
}
