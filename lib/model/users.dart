// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Users userFromJson(String str) => Users.fromJson(json.decode(str));

String userToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    required this.username,
    required this.emailAddress,
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.salt,
    required this.isAdmin,
  });

  String username;
  String emailAddress;
  String name;
  int phoneNumber;
  String password;
  String salt;
  int isAdmin;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        username: json["username"],
        emailAddress: json["email_address"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        password: json["password"],
        salt: json["salt"],
        isAdmin: json["is_admin"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email_address": emailAddress,
        "name": name,
        "phone_number": phoneNumber,
        "password": password,
        "salt": salt,
        "is_admin": isAdmin,
      };
}
