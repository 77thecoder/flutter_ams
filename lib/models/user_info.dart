// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.leaveOnlyDesignatedAccess,
    this.userExists,
    this.passwordsMatch,
    this.accessAllowed,
    this.subordinates,
    this.error,
    this.count,
    this.users,
  });

  bool leaveOnlyDesignatedAccess;
  bool userExists;
  bool passwordsMatch;
  bool accessAllowed;
  List<Subordinate> subordinates;
  bool error;
  int count;
  List<User> users;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    leaveOnlyDesignatedAccess: json["LeaveOnlyDesignatedAccess"],
    userExists: json["UserExists"],
    passwordsMatch: json["PasswordsMatch"],
    accessAllowed: json["AccessAllowed"],
    subordinates: List<Subordinate>.from(json["Subordinates"].map((x) => Subordinate.fromJson(x))),
    error: json["Error"],
    count: json["Count"],
    users: List<User>.from(json["Users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "LeaveOnlyDesignatedAccess": leaveOnlyDesignatedAccess,
    "UserExists": userExists,
    "PasswordsMatch": passwordsMatch,
    "AccessAllowed": accessAllowed,
    "Subordinates": List<dynamic>.from(subordinates.map((x) => x.toJson())),
    "Error": error,
    "Count": count,
    "Users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class Subordinate {
  Subordinate({
    this.personnelNumber,
    this.surname,
    this.name,
    this.patronymic,
    this.description,
    this.login,
  });

  String personnelNumber;
  String surname;
  String name;
  String patronymic;
  String description;
  String login;

  factory Subordinate.fromJson(Map<String, dynamic> json) => Subordinate(
    personnelNumber: json["PersonnelNumber"],
    surname: json["Surname"],
    name: json["Name"],
    patronymic: json["Patronymic"],
    description: json["Description"],
    login: json["Login"],
  );

  Map<String, dynamic> toJson() => {
    "PersonnelNumber": personnelNumber,
    "Surname": surname,
    "Name": name,
    "Patronymic": patronymic,
    "Description": description,
    "Login": login,
  };
}

class User {
  User({
    this.accessAllowed,
    this.personnelNumber,
    this.headPersonnelNumber,
    this.headLogin,
    this.id,
    this.login,
    this.adLogin,
    this.uidAmur,
    this.password,
    this.passwordSha1,
    this.fio,
    this.surname,
    this.name,
    this.patronymic,
    this.domainAccount,
    this.workerId,
    this.startDate,
    this.status,
    this.jobStatus,
    this.truant,
    this.eMail,
    this.phone,
    this.city,
    this.region,
    this.position,
    this.department,
    this.organizationalStructure,
    this.image,
    this.access,
  });

  bool accessAllowed;
  String personnelNumber;
  String headPersonnelNumber;
  String headLogin;
  String id;
  String login;
  String adLogin;
  String uidAmur;
  String password;
  String passwordSha1;
  String fio;
  String surname;
  String name;
  String patronymic;
  String domainAccount;
  String workerId;
  DateTime startDate;
  String status;
  String jobStatus;
  bool truant;
  String eMail;
  String phone;
  String city;
  String region;
  Position position;
  List<OrganizationalStructure> department;
  OrganizationalStructure organizationalStructure;
  String image;
  List<Position> access;

  factory User.fromJson(Map<String, dynamic> json) => User(
    accessAllowed: json["AccessAllowed"],
    personnelNumber: json["PersonnelNumber"],
    headPersonnelNumber: json["HeadPersonnelNumber"],
    headLogin: json["HeadLogin"],
    id: json["ID"],
    login: json["Login"],
    adLogin: json["ADLogin"],
    uidAmur: json["uid_AMUR"],
    password: json["Password"],
    passwordSha1: json["Password_SHA_1"],
    fio: json["FIO"],
    surname: json["Surname"],
    name: json["Name"],
    patronymic: json["Patronymic"],
    domainAccount: json["DomainAccount"],
    workerId: json["WorkerID"],
    startDate: DateTime.parse(json["StartDate"]),
    status: json["Status"],
    jobStatus: json["JobStatus"],
    truant: json["Truant"],
    eMail: json["EMail"],
    phone: json["Phone"],
    city: json["City"],
    region: json["Region"],
    position: Position.fromJson(json["Position"]),
    department: List<OrganizationalStructure>.from(json["Department"].map((x) => OrganizationalStructure.fromJson(x))),
    organizationalStructure: OrganizationalStructure.fromJson(json["OrganizationalStructure"]),
    image: json["Image"],
    access: List<Position>.from(json["Access"].map((x) => Position.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "AccessAllowed": accessAllowed,
    "PersonnelNumber": personnelNumber,
    "HeadPersonnelNumber": headPersonnelNumber,
    "HeadLogin": headLogin,
    "ID": id,
    "Login": login,
    "ADLogin": adLogin,
    "uid_AMUR": uidAmur,
    "Password": password,
    "Password_SHA_1": passwordSha1,
    "FIO": fio,
    "Surname": surname,
    "Name": name,
    "Patronymic": patronymic,
    "DomainAccount": domainAccount,
    "WorkerID": workerId,
    "StartDate": startDate.toIso8601String(),
    "Status": status,
    "JobStatus": jobStatus,
    "Truant": truant,
    "EMail": eMail,
    "Phone": phone,
    "City": city,
    "Region": region,
    "Position": position.toJson(),
    "Department": List<dynamic>.from(department.map((x) => x.toJson())),
    "OrganizationalStructure": organizationalStructure.toJson(),
    "Image": image,
    "Access": List<dynamic>.from(access.map((x) => x.toJson())),
  };
}

class Position {
  Position({
    this.name,
    this.id,
  });

  String name;
  String id;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    name: json["Name"],
    id: json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "ID": id,
  };
}

class OrganizationalStructure {
  OrganizationalStructure({
    this.id,
    this.name,
    this.code,
    this.parentId,
  });

  String id;
  String name;
  String code;
  String parentId;

  factory OrganizationalStructure.fromJson(Map<String, dynamic> json) => OrganizationalStructure(
    id: json["ID"],
    name: json["Name"],
    code: json["Code"],
    parentId: json["ParentID"] == null ? null : json["ParentID"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "Code": code,
    "ParentID": parentId == null ? null : parentId,
  };
}
