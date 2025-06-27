class UserEntity {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? image;
  final String? birthDate;
  final double? height;
  final double? weight;
  final String? eyeColor;
  final HairEntity? hair;
  final AddressEntity? address;
  final CompanyEntity? company;

  const UserEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.image,
    this.birthDate,
    this.height,
    this.weight,
    this.eyeColor,
    this.hair,
    this.address,
    this.company,
  });
}

class HairEntity {
  final String? color;
  final String? type;

  const HairEntity({this.color, this.type});
}

class AddressEntity {
  final String? address;
  final String? city;
  final String? state;
  final String? country;

  const AddressEntity({this.address, this.city, this.state, this.country});
}

class CompanyEntity {
  final String? name;
  final String? department;
  final String? title;

  const CompanyEntity({this.name, this.department, this.title});
}
