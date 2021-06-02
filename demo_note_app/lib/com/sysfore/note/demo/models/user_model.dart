class UserModel {
  String emailId = "";
  String uid = "";
  String userName = "";
  String profilePic = "";
  DateTime? timeStamp = DateTime.now();

  UserModel(
      {this.emailId = "",
      this.uid = "",
      this.userName = "",
      this.timeStamp = null,
      this.profilePic = ""});

  Map<String, dynamic> toMap(UserModel user) {
    var data = Map<String, dynamic>();
    data["uid"] = user.uid;
    data["userName"] = user.userName;
    data["emailId"] = user.emailId;
    data["profilePic"] = user.profilePic;
    data["timeStamp"] = user.timeStamp;
    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    print(mapData);
    this.uid = mapData["uid"];
    this.userName = mapData["userName"];
    this.emailId = mapData["emailId"];
    this.profilePic = mapData["profilePic"];
  }
}
