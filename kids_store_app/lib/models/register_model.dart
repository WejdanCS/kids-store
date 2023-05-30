class RegisterResponse {
  bool? success;
  bool? status;
  String? message;
  Errors? errors;

  RegisterResponse({this.success, this.status, this.message, this.errors});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status'] = status;
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? email;
  List<String>? password;
  List<String>? passwordConfirmation;
  List<String>? name;
  List<String>? address;

  Errors(
      {this.email,
      this.password,
      this.passwordConfirmation,
      this.name,
      this.address});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email']?.cast<String>();
    password = json['password']?.cast<String>();
    passwordConfirmation = json['password_confirmation']?.cast<String>();
    name = json['name']?.cast<String>();
    address = json['address']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}
