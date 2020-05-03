import 'package:plantApp/DataModels/UserInfo.dart';

class ListingSelling {
  String title = "";
  String id = "";
  String datePosted = "";
  String image1Path = "";
  String image2Path = "";
  String image3Path = "";
  String desc = "";
  double price = 0.0;
  PriceLabel priceLabel = PriceLabel.PerKilo;
  bool isNegotiable = false;
  bool isPickup = false;
  bool isDelivery = false;
  bool isCOD = false;
  UserInfo poster;

  ListingSelling(
      {this.title,
      this.id,
      this.datePosted,
      this.image1Path,
      this.image2Path,
      this.image3Path,
      this.price,
      this.desc,
      this.priceLabel,
      this.isCOD,
      this.isDelivery,
      this.isNegotiable,
      this.isPickup,
      this.poster});

  Map<String, dynamic> toJson() => {
        '"title"': '"$title"',
        '"id"': '"$id"',
        '"datePosted"': '"$datePosted"',
        '"image1Path"': '"$image1Path"',
        '"image2Path"': '"$image2Path"',
        '"image3Path"': '"$image3Path"',
        '"desc"': '"$desc"',
        '"price"': '"${price.toString()}"',
        '"priceLabel"': priceLabel == PriceLabel.PerKilo
            ? '"PerKilo"'
            : priceLabel == PriceLabel.PerPiece ? '"PerPiece"' : '"PerBundle"',
        '"isNegotiable"': '"$isNegotiable"',
        '"isPickup"': '"$isPickup"',
        '"isDelivery"': '"$isDelivery"',
        '"isCOD"': '"$isCOD"',
        '"poster"': '"${poster.toJson()}"'
      };

  ListingSelling.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        id = json["id"],
        datePosted = json["datePosted"],
        image1Path = json["image1Path"],
        image2Path = json["image2Path"],
        image3Path = json["image3Path"],
        desc = json["desc"],
        price = double.parse(json["price"]),
        priceLabel = json["priceLabel"] == '"PerKilo"'
            ? PriceLabel.PerKilo
            : json["priceLabel"] == '"PerPiece"'
                ? PriceLabel.PerPiece
                : PriceLabel.PerBundle,
        isNegotiable = json["isNegotiable"],
        isPickup = json["isPickup"],
        isDelivery = json["isDelivery"],
        isCOD = json["isCOD"],
        poster = UserInfo.fromJson(json["poster"]);
}

class ListingBuying {
  String title = "";
  String id = "";
  String datePosted = "";
  String image1Path = "";
  String image2Path = "";
  String image3Path = "";
  String desc = "";
  double price = 0.0;
  PriceLabel priceLabel = PriceLabel.PerKilo;
  bool isNegotiable = false;
  bool isPickup = false;
  bool isDelivery = false;
  bool isCOD = false;
  UserInfo poster;

  ListingBuying(
      {this.title,
      this.id,
      this.datePosted,
      this.image1Path,
      this.image2Path,
      this.image3Path,
      this.price,
      this.desc,
      this.priceLabel,
      this.isCOD,
      this.isDelivery,
      this.isNegotiable,
      this.isPickup,
      this.poster});

  Map<String, dynamic> toJson() => {
        '"title"': '"$title"',
        '"id"': '"$id"',
        '"datePosted"': '"$datePosted"',
        '"image1Path"': '"$image1Path"',
        '"image2Path"': '"$image2Path"',
        '"image3Path"': '"$image3Path"',
        '"desc"': '"$desc"',
        '"price"': '"${price.toString()}"',
        '"priceLabel"': priceLabel == PriceLabel.PerKilo
            ? '"PerKilo"'
            : priceLabel == PriceLabel.PerPiece ? '"PerPiece"' : '"PerBundle"',
        '"isNegotiable"': '"$isNegotiable"',
        '"isPickup"': '"$isPickup"',
        '"isDelivery"': '"$isDelivery"',
        '"isCOD"': '"$isCOD"',
        '"poster"': '"${poster.toJson()}"'
      };

  ListingBuying.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        id = json["id"],
        datePosted = json["datePosted"],
        image1Path = json["image1Path"],
        image2Path = json["image2Path"],
        image3Path = json["image3Path"],
        desc = json["desc"],
        price = double.parse(json["price"]),
        priceLabel = json["priceLabel"] == '"PerKilo"'
            ? PriceLabel.PerKilo
            : json["priceLabel"] == '"PerPiece"'
                ? PriceLabel.PerPiece
                : PriceLabel.PerBundle,
        isNegotiable = json["isNegotiable"],
        isPickup = json["isPickup"],
        isDelivery = json["isDelivery"],
        isCOD = json["isCOD"],
        poster = UserInfo.fromJson(json["poster"]);
}

class ListingSharing {
  String title = "";
  String id = "";
  String datePosted = "";

  String image1Path = "";
  String image2Path = "";
  String image3Path = "";
  String desc = "";
  UserInfo poster;

  ListingSharing(
      {this.title,
      this.id,
      this.datePosted,
      this.image1Path,
      this.image2Path,
      this.image3Path,
      this.desc,
      this.poster});

  Map<String, dynamic> toJson() => {
        '"title"': '"$title"',
        '"id"': '"$id"',
        '"datePosted"': '"$datePosted"',
        '"image1Path"': '"$image1Path"',
        '"image2Path"': '"$image2Path"',
        '"image3Path"': '"$image3Path"',
        '"desc"': '"$desc"',
        '"poster"': '"${poster.toJson()}"'
      };

  ListingSharing.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        id = json["id"],
        datePosted = json["datePosted"],
        image1Path = json["image1Path"],
        image2Path = json["image2Path"],
        image3Path = json["image3Path"],
        desc = json["desc"],
        poster = UserInfo.fromJson(json["poster"]);
}

enum PriceLabel { PerKilo, PerPiece, PerBundle }
enum ListingType { Sharing, Selling, Buying }
