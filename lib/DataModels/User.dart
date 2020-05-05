import 'Listing.dart';
import 'UserInfo.dart';

class User {
  UserInfo userInfo;

  List<ListingBuying> buyListings = [];
  List<ListingSelling> sellListings = [];
  List<ListingSharing> shareListings = [];
  List<dynamic> allListings = [];
  List<dynamic> ownListings = [];

  User() {
    ownListings = [];
    buyListings = [];
    sellListings = [];
    shareListings = [];
    allListings = [];
    userInfo = UserInfo();
  }
}
