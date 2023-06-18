import 'package:chithi/constants/front-end/frontend_constants.dart';
import 'package:flutter/material.dart';

class UserModel {
  final bool isActive;
  final String displayName;
  final String? profilePhoto;
  final String? email;
  final String id;
  final String? bio;
  final List fans;
  final List idols;
  final String? bannerPic;
  final String userName;

  UserModel({
    required this.displayName,
    required this.email,
    required this.isActive,
    required this.profilePhoto,
    required this.id,
    required this.fans,
    required this.idols,
    required this.bannerPic,
    required this.bio,
    required this.userName,
  });

  UserModel copyWith({
    bool? isActive,
    String? displayName,
    String? profilePhoto,
    String? email,
    String? id,
    String? bio,
    List? fans,
    List? idols,
    String? bannerPic,
    String? userName,
  }) {
    return UserModel(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      id: id ?? this.id,
      fans: fans ?? this.fans,
      idols: idols ?? this.idols,
      bannerPic: bannerPic ?? this.bannerPic,
      bio: bio ?? this.bio,
      userName: userName ?? this.userName,
    );
  }

  static UserModel fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      displayName: data['displayName'],
      email: data['email'],
      bio: data['bio'],
      isActive: data['isActive'],
      profilePhoto: data['profilePhoto'],
      bannerPic: data['bannerPic'],
      fans: data['fans'],
      idols: data['idols'],
      userName: data['userName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'id': id,
      'displayName': displayName,
      'email': email,
      'bio': bio,
      'isActive': isActive,
      'profilePhoto': profilePhoto,
      'bannerPic': bannerPic,
      'fans': fans,
      'idols': idols,
    };
  }

  ImageProvider<Object> profilePicReady() {
    if (profilePhoto != null) {
      return NetworkImage(profilePhoto!);
    } else {
      return const AssetImage(Assets.defaultProfilePic);
    }
  }
}
