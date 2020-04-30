import 'package:plantApp/DataModels/UserInfo.dart';

class ListingSelling {
  String title = "";
  String id = "";
  String datePosted = "";
  List<String> imagesPath = [];
  String desc = "";
  double price = 0.0;
  PriceLabel priceLabel = PriceLabel.PerKilo;
  bool isNegotiable = false;
  bool isPickup = false;
  bool isDelivery = false;
  bool isCOD = false;
  String posterName;
  String posterProfilePictureLink;
}

class ListingBuying {
  String title = "";
  String id = "";
  String datePosted = "";
  List<String> imagesPath = [];
  String desc = "";
  double maxPrice = 0.0;
  PriceLabel maxPriceLabel = PriceLabel.PerKilo;
  bool isNegotiable = false;
  bool isPickup = false;
  bool isDelivery = false;
  bool isCOD = false;
  String posterName;
  String posterProfilePictureLink;
}

class ListingSharing {
   String title = "";
  String id = "";
  String datePosted = "";
  List<String> imagesPath = [];
  String desc = "";    
  List<String> flairs = [];
  String posterName;
  String posterProfilePictureLink;
}

enum PriceLabel { PerKilo, PerPiece }
