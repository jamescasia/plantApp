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
}

class ListingBuying {
  String title = "";
  String id = "";
  String datePosted = "";

  String image1Path = "";
  String image2Path = "";
  String image3Path = "";
  String desc = "";
  double maxPrice = 0.0;
  PriceLabel maxPriceLabel = PriceLabel.PerKilo;
  bool isNegotiable = false;
  bool isPickup = false;
  bool isDelivery = false;
  bool isCOD = false;
  UserInfo poster;
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
}

enum PriceLabel { PerKilo, PerPiece, PerBundle }
enum ListingType { Sharing, Selling, Buying}