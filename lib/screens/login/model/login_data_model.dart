import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dadtaModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.success,
    this.message,
    this.firstName,
    this.lastName,
    this.dob,
    this.email,
    this.phoneNo,
    this.password,
  });

  bool? success;
  String? message;
  String? firstName;
  String? lastName;
  String? dob;
  String? email;
  String? phoneNo;
  String? password;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "emial": email,
        "phoneNo": phoneNo,
        "password": password,
      };
}
