// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InstitutionModel {
  final String name;
  final String code;
  final String email;
  final String phone;
  final String address;
  final String type;
  final String establishmentCode;
  final String licenseNumber;
  final String affiliation;
  final String description;
  final String socialMedia;
  final String website;
  final String imageUrl;
  final String uniqueCode;
  InstitutionModel({
    required this.name,
    required this.code,
    required this.email,
    required this.phone,
    required this.address,
    required this.type,
    required this.establishmentCode,
    required this.licenseNumber,
    required this.affiliation,
    required this.description,
    required this.socialMedia,
    required this.website,
    required this.imageUrl,
    required this.uniqueCode,
  });

  InstitutionModel copyWith({
    String? name,
    String? code,
    String? email,
    String? phone,
    String? address,
    String? type,
    String? establishmentCode,
    String? licenseNumber,
    String? affiliation,
    String? description,
    String? socialMedia,
    String? website,
    String? imageUrl,
    String? uniqueCode,
  }) {
    return InstitutionModel(
      name: name ?? this.name,
      code: code ?? this.code,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      type: type ?? this.type,
      establishmentCode: establishmentCode ?? this.establishmentCode,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      affiliation: affiliation ?? this.affiliation,
      description: description ?? this.description,
      socialMedia: socialMedia ?? this.socialMedia,
      website: website ?? this.website,
      imageUrl: imageUrl ?? this.imageUrl,
      uniqueCode: uniqueCode ?? this.uniqueCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
      'email': email,
      'phone': phone,
      'address': address,
      'type': type,
      'establishmentCode': establishmentCode,
      'licenseNumber': licenseNumber,
      'affiliation': affiliation,
      'description': description,
      'socialMedia': socialMedia,
      'website': website,
      'imageUrl': imageUrl,
      'uniqueCode': uniqueCode,
    };
  }

  factory InstitutionModel.fromMap(Map<String, dynamic> map) {
    return InstitutionModel(
      name: map['name'] as String,
      code: map['code'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      type: map['type'] as String,
      establishmentCode: map['establishmentCode'] as String,
      licenseNumber: map['licenseNumber'] as String,
      affiliation: map['affiliation'] as String,
      description: map['description'] as String,
      socialMedia: map['socialMedia'] as String,
      website: map['website'] as String,
      imageUrl: map['imageUrl'] as String,
      uniqueCode: map['uniqueCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InstitutionModel.fromJson(String source) => InstitutionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InstitutionModel(name: $name, code: $code, email: $email, phone: $phone, address: $address, type: $type, establishmentCode: $establishmentCode, licenseNumber: $licenseNumber, affiliation: $affiliation, description: $description, socialMedia: $socialMedia, website: $website, imageUrl: $imageUrl, uniqueCode: $uniqueCode)';
  }

  @override
  bool operator ==(covariant InstitutionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.code == code &&
      other.email == email &&
      other.phone == phone &&
      other.address == address &&
      other.type == type &&
      other.establishmentCode == establishmentCode &&
      other.licenseNumber == licenseNumber &&
      other.affiliation == affiliation &&
      other.description == description &&
      other.socialMedia == socialMedia &&
      other.website == website &&
      other.imageUrl == imageUrl &&
      other.uniqueCode == uniqueCode;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      code.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      type.hashCode ^
      establishmentCode.hashCode ^
      licenseNumber.hashCode ^
      affiliation.hashCode ^
      description.hashCode ^
      socialMedia.hashCode ^
      website.hashCode ^
      imageUrl.hashCode ^
      uniqueCode.hashCode;
  }
}
