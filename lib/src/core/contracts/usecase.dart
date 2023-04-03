import 'repository.dart';

abstract class Usecase<ReturnType, ParameterType> {
  Usecase(this.repository);

  final BaseRepository repository;

  Future<ReturnType> call(ParameterType param);
}
