// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

ProfileUser profileFromJson(String str) =>
    ProfileUser.fromJson(json.decode(str));

String profileToJson(ProfileUser data) => json.encode(data.toJson());

class ProfileUser {
  ProfileUser({
    this.id,
    this.email,
    this.userName,
    this.firstName,
    this.lastName,
    this.birthday,
    this.phoneNumber,
    this.gender,
    this.description,
    this.addDateTime,
    this.lastModifyDateTime,
    this.lastLoginDateTime,
    this.fullName,
    this.name,
    this.profileImage,
    this.contacts,
  });

  String id;
  dynamic email;
  String userName;
  String firstName;
  String lastName;
  DateTime birthday;
  dynamic phoneNumber;
  String gender;
  dynamic description;
  DateTime addDateTime;
  DateTime lastModifyDateTime;
  DateTime lastLoginDateTime;
  String fullName;
  String name;
  ProfileImage profileImage;
  List<dynamic> contacts;

  factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
        id: json["id"],
        email: json["email"],
        userName: json["userName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        birthday: DateTime.parse(json["birthday"]),
        phoneNumber: json["phoneNumber"],
        gender: json["gender"],
        description: json["description"],
        addDateTime: DateTime.parse(json["addDateTime"]),
        lastModifyDateTime: DateTime.parse(json["lastModifyDateTime"]),
        lastLoginDateTime: DateTime.parse(json["lastLoginDateTime"]),
        fullName: json["fullName"],
        name: json["name"],
        profileImage: ProfileImage.fromJson(json["profileImage"]),
        contacts: List<dynamic>.from(json["contacts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "userName": userName,
        "firstName": firstName,
        "lastName": lastName,
        "birthday": birthday.toIso8601String(),
        "phoneNumber": phoneNumber,
        "gender": gender,
        "description": description,
        "addDateTime": addDateTime.toIso8601String(),
        "lastModifyDateTime": lastModifyDateTime.toIso8601String(),
        "lastLoginDateTime": lastLoginDateTime.toIso8601String(),
        "fullName": fullName,
        "name": name,
        "profileImage": profileImage.toJson(),
        "contacts": List<dynamic>.from(contacts.map((x) => x)),
      };
}

class ProfileImage {
  ProfileImage({
    this.id,
    this.description,
    this.type,
    this.contentType,
    this.title,
    this.sequence,
    this.notes,
  });

  int id;
  dynamic description;
  dynamic type;
  String contentType;
  dynamic title;
  int sequence;
  dynamic notes;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        id: json["id"],
        description: json["description"],
        type: json["type"],
        contentType: json["contentType"],
        title: json["title"],
        sequence: json["sequence"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "type": type,
        "contentType": contentType,
        "title": title,
        "sequence": sequence,
        "notes": notes,
      };
}
