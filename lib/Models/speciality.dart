class Speciality {
  int? id;
  String? name;

  Speciality(this.id, this.name);

  Speciality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
