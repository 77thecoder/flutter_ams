class User {
  final bool isAuth;
  final String login;
  final String FIO;
  final String TN;
  final String phones;
  final String Email;
  final String Position;
  final String Department;

  User({
    this.isAuth,
    this.login,
    this.FIO,
    this.TN,
    this.phones,
    this.Email,
    this.Position,
    this.Department
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      isAuth: json['isAuth'],
      login: json['login'],
      FIO: json['FIO'],
      TN: json['TN'],
      phones: json['phones'],
      Email: json['Email'],
      Position: json['Position'],
      Department: json['Department']
    );
  }

  bool get getIsAuth => isAuth;
  String get getLogin => login;
  String get getFIO => FIO;
  String get getTN => TN;
  String get getPhones => phones;
  String get getEmail => Email;
  String get getPosition => Position;
  String get getDepartment => Department;
}