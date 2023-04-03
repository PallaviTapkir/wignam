abstract class BaseNetworkResponse {
  BaseNetworkResponse({
    required this.status,
    this.requestId,
    this.profileExists = false,
    this.jwt
  });

  final bool status;
  String? requestId;
  bool? profileExists;
  String? jwt;
}
