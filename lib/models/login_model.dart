class LoginResponseModel {
  // ignore: non_constant_identifier_names
  final String access_token;
  final String error;

  // ignore: non_constant_identifier_names
  LoginResponseModel({this.access_token, this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      access_token: json["access_token"] != null ? json["access_token"]: "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

class LoginRequestModel {
  String phone;
  String password;

  LoginRequestModel({
    this.phone,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'phone': phone.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
