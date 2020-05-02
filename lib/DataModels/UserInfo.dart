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

  createUserInfo(String name, String email, String bio, String ppLink, String mainPhoneNumber,
      String altPhoneNumber, String address, String addressLatitude, String addressLongitude) {
    this.name = name;
    this.bio = bio;
    this.email = email;
    this.address = address;
    this.ppLink = ppLink;
    this.mainPhoneNumber = mainPhoneNumber;
    this.altPhoneNumber = altPhoneNumber;
    this.addressLatitude = addressLatitude;
    this.addressLongitude = addressLongitude;
    this.address = address;

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
        bio = json["bio"],
        mainPhoneNumber = json["mainPhoneNumber"],
        altPhoneNumber = json["altPhoneNumber"],
        addressLongitude = json["addressLongitude"],
        addressLatitude = json["addressLatitude"],
        address = json["address"],
        ppLink = json["ppLink"];
}
