import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../../core/api/network_response.dart';
import '../../../../../core/contracts/usecase.dart';
import '../../../../../core/value/strings.dart';
import '../repository/repository.dart';

class SubmitUserProfileUsecaseParams {
  SubmitUserProfileUsecaseParams(
      {required this.name, required this.email, required this.jwtToken});

  final String name;
  final String email;
  final String jwtToken;
}

class SubmitUserProfileUsecase extends Usecase<Either<String, NetworkResponse>,
    SubmitUserProfileUsecaseParams> {
  SubmitUserProfileUsecase(BaseSubmitProfileRepository repository)
      : super(repository);

  @override
  Future<Either<String, NetworkResponse>> call(
      SubmitUserProfileUsecaseParams param) async {
    try {
      final NetworkResponse response =
          await (repository as BaseSubmitProfileRepository).submitUserProfile(
              email: param.email, name: param.name, jwtToken: param.jwtToken);
      return Right(response);
    } catch (error) {
      log('SubmitUserProfileUsecase - Unexpected Error: $error');
      return const Left(Strings.errorMessageSomethingWentWrong);
    }
  }
}
