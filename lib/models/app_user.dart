import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  @JsonSerializable(explicitToJson: true)
  const factory AppUser({
    required String email,
    required String uid,
    required String? photoUrl,
    required String username,
    required String bio,
    required List<AppUser> followers,
    required List<AppUser> following,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
