import 'package:test_blocs/domain/entities/auth/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.firstName,
    super.lastName,
    super.email,
    super.phone,
    super.image,
    super.birthDate,
    super.height,
    super.weight,
    super.eyeColor,
    super.hair,
    super.address,
    super.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      birthDate: json['birthDate'],
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      eyeColor: json['eyeColor'],
      hair: json['hair'] != null ? HairModel.fromJson(json['hair']) : null,
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
      company: json['company'] != null
          ? CompanyModel.fromJson(json['company'])
          : null,
    );
  }
}

class HairModel extends HairEntity {
  const HairModel({super.color, super.type});

  factory HairModel.fromJson(Map<String, dynamic> json) {
    return HairModel(color: json['color'], type: json['type']);
  }
}

class AddressModel extends AddressEntity {
  const AddressModel({super.address, super.city, super.state, super.country});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }
}

class CompanyModel extends CompanyEntity {
  const CompanyModel({super.name, super.department, super.title});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'],
      department: json['department'],
      title: json['title'],
    );
  }
}
