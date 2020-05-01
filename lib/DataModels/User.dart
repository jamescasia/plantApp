import 'UserInfo.dart';
import 'Listing.dart';

class User {
  UserInfo userInfo;
  List<ListingBuying> userBuyListings = [];
  List<ListingSelling> userSellListings = [];
  List<ListingSharing> userShareListings = [];

  List<ListingBuying> globalBuyListings = [];
  List<ListingSelling> globalSellListings = [];
  List<ListingSharing> globalShareListings = [];

  User(){

    userBuyListings = [];
    userSellListings = [];
    userShareListings = [];

    globalBuyListings = [];
    globalSellListings = [];
    globalShareListings = [];
    userInfo = UserInfo("", "", "");
  }
}
