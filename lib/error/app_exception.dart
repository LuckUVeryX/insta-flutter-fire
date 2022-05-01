abstract class AppException implements Exception {
  AppException([this.message]);
  final String? message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppException && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
