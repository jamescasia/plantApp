import 'Listing.dart';
import 'UserInfo.dart';

class User {
  UserInfo userInfo;

  List<ListingBuying> buyListings = [];
  List<ListingSelling> sellListings = [];
  List<ListingSharing> shareListings = [];

  User() {
    buyListings = [];
    sellListings = [];
    shareListings = [];
    userInfo = UserInfo();
  }
}
