// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      email: json['email'] as String,
      uid: json['uid'] as String,
      photoUrl: json['photoUrl'] as String?,
      username: json['username'] as String,
      bio: json['bio'] as String,
      followers: (json['followers'] as List<dynamic>)
          .map((e) => _AppUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      following: (json['following'] as List<dynamic>)
          .map((e) => _AppUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'uid': instance.uid,
      'photoUrl': instance.photoUrl,
      'username': instance.username,
      'bio': instance.bio,
      'followers': instance.followers.map((e) => e.toJson()).toList(),
      'following': instance.following.map((e) => e.toJson()).toList(),
    };
