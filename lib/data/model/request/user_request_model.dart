// import 'dart:convert';

// UserRequest authRequestFromJson(String str) =>
//     UserRequest.fromJson(json.decode(str));

// String authRequestToJson(UserRequest data) => json.encode(data.toJson());

// class UserRequest {
//   UserRequest(
//       {this.phone = '',
//       this.otp = '',
//       this.password = '',
//       this.name = '',
//       this.fromForgetPassword = false,
//       this.newPassword = '',
//       this.confirmPassword = ''});

//   String phone;
//   String otp;
//   String password;
//   String name;
//   bool fromForgetPassword;
//   String newPassword;
//   String confirmPassword;

//   factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
//       phone: json["phone"],
//       otp: json["otp"],
//       password: json["password"],
//       name: json["name"],
//       fromForgetPassword: json["fromForgetPassword"],
//       newPassword: json["new_password"],
//       confirmPassword: json["confirm_password"]);

//   Map<String, dynamic> toJson() => {
//         "phone": phone,
//         "otp": otp,
//         "password": password,
//         "name": name,
//         "fromForgetPassword": fromForgetPassword,
//         "new_password": newPassword,
//         "confirm_password": confirmPassword
//       };
// }
