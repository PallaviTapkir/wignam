abstract class EntityBase {
  EntityBase();

  factory EntityBase.fromJson(dynamic data) {
    throw UnimplementedError();
  }

  dynamic toJson();
}
