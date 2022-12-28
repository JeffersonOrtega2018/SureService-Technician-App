class TechnicianLogin {
  String? userName;
  String? password;

  TechnicianLogin(this.userName, this.password);

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'password': password,
    };
  }
}