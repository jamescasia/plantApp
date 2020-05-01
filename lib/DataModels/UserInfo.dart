class UserInfo {
  // String uid;
  String name;
  String email;
  // String username;
  // String bio;
  String ppLink;

  UserInfo(this.name, this.email, this.ppLink);

  Map<String, dynamic> toJson() => {
        // '"uid"': '"$uid"',
        '"name"': '"$name"',
        '"email"': '"$email"',
        // '"username"': '"$username"',
        // '"bio"': '"$bio"',
        '"ppID"': '"$ppLink"',
      };

  UserInfo.fromJson(Map<String, dynamic> json)
      : //uid = json["uid"],
        name = json["name"],
        email = json["email"],
        // username = json["username"],
        // bio = json["bio"],
        ppLink = json["ppLink"];
}
