import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../../core/api/network_response.dart';
import '../../../../../core/contracts/usecase.dart';
import '../../../../../core/value/strings.dart';
import '../repository/repository.dart';

class VerifyOTPUsecaseParams {
  VerifyOTPUsecaseParams({required this.requestId, required this.otp});

  final String requestId;
  final String otp;
}

class VerifyOTPUsecase
    extends Usecase<Either<String, NetworkResponse>, VerifyOTPUsecaseParams> {
  VerifyOTPUsecase(BaseVerifyOTPRepository repository) : super(repository);

  @override
  Future<Either<String, NetworkResponse>> call(
      VerifyOTPUsecaseParams param) async {
    final NetworkResponse response =
    await (repository as BaseVerifyOTPRepository)
        .verifyOTP(requestId: param.requestId, otp: param.otp);
    return Right(response);
    try {
      final NetworkResponse response =
          await (repository as BaseVerifyOTPRepository)
              .verifyOTP(requestId: param.requestId, otp: param.otp);
      return Right(response);
    } catch (error) {
      log('VerifyOTPUsecase - Error: $error');
      return const Left(Strings.errorMessageSomethingWentWrong);
    }
  }
}
