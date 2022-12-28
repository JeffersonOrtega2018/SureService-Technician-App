import 'package:login/Models/Speciality.dart';

class Technician {
  int? id;
  String? username;
  String? name;
  String? lastName;
  String? email;
  String? dni;
  String? telephoneNumber;
  String? imageUrl;
  String? professionalProfile;
  int? valoration;
  String? district;
  int? disponibility;
  Speciality? speciality;

  Technician(
      this.id,
      this.username,
      this.name,
      this.lastName,
      this.email,
      this.dni,
      this.telephoneNumber,
      this.imageUrl,
      this.professionalProfile,
      this.valoration,
      this.district,
      this.disponibility,
      this.speciality);

  Technician.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    dni = json['dni'];
    telephoneNumber = json['telephone_number'];
    imageUrl = json['image_url'];
    professionalProfile = json['professional_profile'];
    valoration = json['valoration'] * 1;
    district = json['district'];
    disponibility = json['disponibility'] * 1;
    speciality = Speciality.fromJson(json['speciality']);
  }
}
