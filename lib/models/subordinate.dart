class Subordinate {
  String login;
  String iD;
  String aDLogin;
  String uidAMUR;
  String fIO;
  String workerID;

  Subordinate({
    this.login,
      this.iD,
      this.aDLogin,
      this.uidAMUR,
      this.fIO,
      this.workerID
  });

  Subordinate.fromJson(Map<String, dynamic> json) {
    login = json['Login'];
    iD = json['ID'];
    aDLogin = json['ADLogin'];
    uidAMUR = json['uid_AMUR'];
    fIO = json['FIO'];
    workerID = json['WorkerID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Login'] = this.login;
    data['ID'] = this.iD;
    data['ADLogin'] = this.aDLogin;
    data['uid_AMUR'] = this.uidAMUR;
    data['FIO'] = this.fIO;
    data['WorkerID'] = this.workerID;
    return data;
  }
}