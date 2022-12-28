class Client {
  int? id;
  String? username;
  String? name;
  String? lastName;
  String? email;
  String? dni;
  String? telephoneNumber;
  String? imageUrl;
  double? amountReservation;

  Client(this.id, this.username, this.name, this.lastName, this.email, this.dni,
      this.telephoneNumber, this.imageUrl, this.amountReservation);

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    dni = json['dni'];
    telephoneNumber = json['telephone_number'];
    imageUrl = json['image_url'];
    amountReservation = json['amount_reservation'] * 1.0;
  }
}
