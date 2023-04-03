import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../../core/api/network_response.dart';
import '../../../../../core/contracts/usecase.dart';
import '../../../../../core/value/strings.dart';
import '../repository/repository.dart';

class SendLoginOTPUsecaseParams {
  SendLoginOTPUsecaseParams({
    required this.mobile,
  });

  final String mobile;
}

class SendLoginOTPUsecase
    extends Usecase<Either<String, NetworkResponse>, SendLoginOTPUsecaseParams> {
  SendLoginOTPUsecase(BaseLoginRepository repository) : super(repository);

  @override
  Future<Either<String, NetworkResponse>> call(SendLoginOTPUsecaseParams param) async {
    try {
      final NetworkResponse response =
          await (repository as BaseLoginRepository).sendLoginOTP(
        mobile: param.mobile,
      );
      return Right(response);

    } catch (error) {
      log('SendLoginOTPUsecase - Unexpected Error: $error');
      return const Left(Strings.errorMessageSomethingWentWrong);
    }
  }
}
