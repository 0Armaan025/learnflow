// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String password;
  final String profileImageUrl;
  final String uid;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.profileImageUrl,
    required this.uid,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? profileImageUrl,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'profileImageUrl': profileImageUrl,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profileImageUrl: map['profileImageUrl'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, password: $password, profileImageUrl: $profileImageUrl, uid: $uid)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.profileImageUrl == profileImageUrl &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      profileImageUrl.hashCode ^
      uid.hashCode;
  }
}


