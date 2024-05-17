import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class Address {
  final String city;
  final String street;
  final int number;
  final String zipcode;

  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Name {
  final String firstname;
  final String lastname;

  Name({required this.firstname, required this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);
}

@JsonSerializable()
class UserModel {
  static int _latestId = 0;

  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  final String phone;
  final Address address;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.address,
  }) {
    _latestId = id > _latestId ? id : _latestId;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  static List<UserModel> fromList(List<dynamic> data) =>
      data.map((e) => UserModel.fromJson(e)).toList();

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  static int getLatestId() {
    return _latestId;
  }
}

void addUserToJsonFile(UserModel newUser) {
  File file = File('assets/users.json');
  String jsonData = file.readAsStringSync();
  List<dynamic> userList = json.decode(jsonData);
  List<UserModel> existingUsers = UserModel.fromList(userList);
  existingUsers.add(newUser);
  List<Map<String, dynamic>> updatedJsonList =
      existingUsers.map((user) => user.toJson()).toList();
  String updatedJsonData = json.encode(updatedJsonList);
  file.writeAsStringSync(updatedJsonData);
}
