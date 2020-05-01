class UserInfo {
  String name = "";
  String email = "";
  String bio = "";
  String address = "";
  String ppLink = "";
  String mainPhoneNumber = "";
  String altPhoneNumber = "";
  String addressLatitude = "";
  String addressLongitude = "";

  UserInfo();

  createUserInfo(String name, String bio, String ppLink, String mainPhoneNumber,
      String altPhoneNumber, String addressLatitude, String addressLongitude) {
    this.name = name;
    this.bio = bio;
    this.email = email;
    this.address = address;
    this.ppLink = ppLink;
    this.mainPhoneNumber = mainPhoneNumber;
    this.altPhoneNumber = altPhoneNumber;
    this.addressLatitude = addressLatitude;
    this.addressLongitude = addressLongitude;

    return this;
  }

  Map<String, dynamic> toJson() => {
        // '"uid"': '"$uid"',
        '"name"': '"$name"',
        '"email"': '"$email"',
        '"address"': '"$address"',
        '"bio"': '"$bio"',
        '"ppLink"': '"$ppLink"',
        '"mainPhoneNumber"': '"$mainPhoneNumber"',
        '"altPhoneNumber"': '"$altPhoneNumber"',

        '"addressLatitude"': '"$addressLatitude"',
        '"addressLongitude"': '"$addressLongitude"',
      };

  UserInfo.fromJson(Map<String, dynamic> json)
      : //uid = json["uid"],
        name = json["name"],
        email = json["email"],
        address = json["address"],
        bio = json["bio"],
        mainPhoneNumber = json["mainPhoneNumber"],
        altPhoneNumber = json["altPhoneNumber"],
        addressLongitude = json["addressLongitude"],
        addressLatitude = json["addressLatitude"],
        ppLink = json["ppLink"];
}
