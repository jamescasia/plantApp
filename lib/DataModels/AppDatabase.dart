import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:plantApp/DataModels/Listing.dart';
import 'package:plantApp/DataModels/UserInfo.dart';

class AppDatabase {
  FirebaseDatabase fDatabase;
  DatabaseReference personalUserRef;
  DatabaseReference userDataRef;
  DatabaseReference sellListingsRef;
  DatabaseReference buyListingsRef;
  DatabaseReference shareListingsRef;
  DatabaseReference usersRef;
  FirebaseStorage fStorage;
  StorageReference imagesRef;
  String userId;

  AppDatabase() {
    fStorage = FirebaseStorage.instance;
    fDatabase = FirebaseDatabase.instance;
    userDataRef = fDatabase.reference().child('App/UserData');
    sellListingsRef = fDatabase.reference().child('App/Listings/SellListings');

    buyListingsRef = fDatabase.reference().child('App/Listings/BuyListings');
    shareListingsRef =
        fDatabase.reference().child('App/Listings/ShareListings');
    usersRef = fDatabase.reference().child('App/Users');
    imagesRef = fStorage.ref().child('images');
  }

  initializeUserDatabase(String uid) {
    userId = uid;
    personalUserRef = fDatabase.reference().child('App/UserData/${uid}');
  }

  addNewUser(
      String name,
      String email,
      String uid,
      String ppLink,
      String bio,
      String mainPhoneNumber,
      String altPhoneNumber,
      String address,
      String addressLatitude,
      String addressLongitude) {
    usersRef.child(uid).set(email);
    userDataRef.child(uid).set({
      "UserInfo": UserInfo()
          .createUserInfo(name, email, bio, ppLink, mainPhoneNumber,
              altPhoneNumber, address, addressLatitude, addressLongitude)
          .toJson(),
    });
  }

  userExists(String uid) async {
    var exists;
    try {
      await usersRef.once().then((data) {
        exists = data.value[uid] != null;
      });
    } catch (E) {
      exists = false;
    }
    print(exists);
    return exists;
  }

  addNewSellListing(ListingSelling listing) async {
    var key = personalUserRef.child('SellListings').push().key;
    listing.id = key;
    personalUserRef.child('SellListings/$key').set(true);
    sellListingsRef.child(key).set(listing.toJson());
  }

  addNewBuyListing(ListingBuying listing) async {
    var key = personalUserRef.child('BuyListings').push().key;
    listing.id = key;
    personalUserRef.child('BuyListings/$key').set(true);
    buyListingsRef.child(key).set(listing.toJson());
  }

  addNewShareListing(ListingSharing listing) async {
    var key = personalUserRef.child('ShareListings').push().key;
    listing.id = key;
    personalUserRef.child('ShareListings/$key').set(true);
    shareListingsRef.child(key).set(listing.toJson());
  }

  updateSellListing(ListingSelling listing) {
    sellListingsRef.child(listing.id).set(listing.toJson());
    print("solo task in json");
    print(listing.toJson());
  }

  updateBuyListing(ListingBuying listing) {
    buyListingsRef.child(listing.id).set(listing.toJson());
    print("solo task in json");
    print(listing.toJson());
  }

  updateShareListing(ListingSharing listing) {
    shareListingsRef.child(listing.id).set(listing.toJson());
    print("solo task in json");
    print(listing.toJson());
  }

  deleteSellListing(ListingSelling listing) {
    personalUserRef.child('SellListings/${listing.id}').set(null);
    sellListingsRef.child(listing.id).set(null);
  }

  deleteBuyListing(ListingBuying listing) {
    personalUserRef.child('BuyListings/${listing.id}').set(null);
    buyListingsRef.child(listing.id).set(null);
  }

  deleteShareListing(ListingSharing listing) {
    personalUserRef.child('ShareListings/${listing.id}').set(null);
    shareListingsRef.child(listing.id).set(null);
  }

  fetchSellListings() async {
    List<String> listOfSellListingsIds = [];

    List<ListingSelling> listOfSellListings = [];

    try {
      await sellListingsRef.once().then((data) async {
        data.value.forEach((k, value) {
          ListingSelling ls =
              ListingSelling.fromJson(jsonDecode(value.toString()));
          listOfSellListings.add(ls);
        });
      });
    } catch (E) {
      print("error fetching sell ${E.toString()}");
    }

    return listOfSellListings;
  }

  fetchBuyListings() async {
    List<String> listOfBuyListingsIds = [];

    List<ListingBuying> listOfBuyListings = [];

    try {
      await buyListingsRef.once().then((data) async {
        data.value.forEach((k, value) {
          ListingBuying ls =
              ListingBuying.fromJson(jsonDecode(value.toString()));
          listOfBuyListings.add(ls);
        });
      });
    } catch (E) {}

    return listOfBuyListings;
  }

  fetchShareListings() async {
    List<String> listOfShareListingsIds = [];

    List<ListingSharing> listOfShareListings = [];

    try {
      await shareListingsRef.once().then((data) async {
        data.value.forEach((k, value) {
          ListingSharing ls =
              ListingSharing.fromJson(jsonDecode(value.toString()));
          listOfShareListings.add(ls);
        });
      });
    } catch (E) {}

    return listOfShareListings;
  }

  // addNewSoloTask(SoloTask soloTask) {
  //   var key = personalUserRef.child('SoloTasks').push().key;
  //   print("key");
  //   print(key);
  //   soloTask.id = key;
  //   personalUserRef.child('SoloTasks/$key').set(false);
  //   soloTasksRef.child(key).set(soloTask.toJson());
  // }

  // addNewCollabTask(CollabTask collabTask) {
  //   var key = personalUserRef.child('CollabTasks').push().key;
  //   print("key");
  //   print(key);
  //   collabTask.id = key;
  //   personalUserRef.child('CollabTasks/$key').set(false);
  //   collabTasksRef.child(key).set(collabTask.toJson());
  // }

  // updateCollabTask(CollabTask collabTask) {
  //   // personalUserRef
  //   //     .child('CollabTasks/${collabTask.id}')
  //   //     .set(collabTask.completed);
  //   collabTasksRef.child(collabTask.id).set(collabTask.toJson());
  //   print("solo task in json");
  //   print(collabTask.toJson());
  // }

  // deleteSoloTask(SoloTask soloTask) {
  //   personalUserRef.child('SoloTasks/${soloTask.id}').set(null);
  //   soloTasksRef.child(soloTask.id).set(null);
  // }

  // deleteCollabTask(CollabTask collabTask) {
  //   personalUserRef.child('CollabTasks/${collabTask.id}').set(null);
  //   collabTasksRef.child(collabTask.id).set(null);
  // }

  // updateSoloTask(SoloTask soloTask) {
  //   personalUserRef.child('SoloTasks/${soloTask.id}').set(soloTask.completed);
  //   soloTasksRef.child(soloTask.id).set(soloTask.toJson());
  //   print("solo task in json");
  //   print(soloTask.toJson());
  // }

  // fetchSoloTasks() async {
  //   List<String> listOfSoloTaskIds = [];

  //   List<SoloTask> listOfSoloTasks = [];

  //   try {
  //     await personalUserRef.child("SoloTasks").once().then((data) {
  //       // print("solotasks");
  //       // print(data.value);
  //       data.value.forEach((k, value) {
  //         listOfSoloTaskIds.add(k.toString());
  //       });
  //     });

  //     print(listOfSoloTaskIds);

  //     await soloTasksRef.once().then((data) {
  //       data.value.forEach((k, value) {
  //         // print(k);
  //         // print(value);

  //         SoloTask sT = SoloTask.fromJson(jsonDecode(value.toString()));
  //         if (listOfSoloTaskIds.contains(k.toString())) {
  //           if (!sT.archived) {
  //             listOfSoloTasks.add(sT);
  //           }
  //         }
  //       });
  //     });
  //     print(listOfSoloTasks);
  //   } catch (E) {
  //     print("error fetching solo tasks ${E.toString()}");
  //   }

  //   return listOfSoloTasks;
  // }

  // fetchUserStats() async {
  //   Stats stats;

  //   try {
  //     await personalUserRef.child("Stats").once().then((data) {
  //       stats = Stats.fromJson(jsonDecode(data.value.toString()));
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  //   return stats;
  // }

  // updateUserStats(Stats stats) async {
  //   personalUserRef.child('Stats').set(stats.toJson());
  // }

  fetchUserInfo(String uid) async {
    UserInfo userInfo;

    try {
      await personalUserRef.child("UserInfo").once().then((data) {
        userInfo = UserInfo.fromJson(jsonDecode(data.value.toString()));
      });
    } catch (e) {
      print(e);
    }
    return userInfo;
  }

  // userExistsThruEmail(String email) async {
  //   var exists = false;
  //   var uid = "";
  //   try {
  //     await usersRef.once().then((data) {
  //       data.value.forEach((k, value) {
  //         if (!exists) {
  //           exists = value == email;
  //           uid = k;
  //         }
  //       });
  //     });
  //   } catch (E) {
  //     print(E.toString());
  //     exists = false;
  //   }

  //   print("does exist");
  //   print(exists);

  //   return {"exists": exists, "uid": uid.replaceAll('"', "")};
  // }

  // userFetchName(String uid) async {
  //   String name = "";
  //   try {
  //     await userDataRef.child("$uid/UserInfo").once().then((data) {
  //       name = data.value['"name"'];
  //     });
  //   } catch (E) {
  //     print(E.toString());
  //   }
  //   return name.replaceAll('"', "");
  // }

  // userAddCollabTaskToCollaborator(String uid, CollabTask collabTask) async {
  //   try {
  //     await userDataRef
  //         .child("$uid/CollabTasks/${collabTask.id}")
  //         .set(collabTask.completed);
  //   } catch (e) {}
  // }

  // userFetchCollabTaskUsingId(String id) async {
  //   CollabTask clbTsk = CollabTask();
  //   try {
  //     await collabTasksRef.child(id).once().then((data) {
  //       clbTsk = CollabTask.fromJson(jsonDecode(data.value.toString()));
  //     });
  //   } catch (E) {}

  //   print("fetched through uid");
  //   print(clbTsk.toJson());

  //   return clbTsk;
  // }

  // notifyUser(String uid, CollabNotification notif) async {
  //   try {
  //     await userDataRef
  //         .child("$uid/Notifications/${notif.taskName}")
  //         .set(notif.toJson());
  //   } catch (e) {}
  // }

  // fetchNotifications(String uid) async {
  //   List<CollabNotification> notifs = [];

  //   try {
  //     await personalUserRef.child("Notifications").once().then((data) {
  //       data.value.forEach((k, value) {
  //         CollabNotification nf =
  //             CollabNotification.fromJson(jsonDecode(value.toString()));
  //         notifs.add(nf);
  //       });
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  //   return notifs;
  // }

  // deleteNotification(String taskName) async {
  //   try {
  //     await personalUserRef.child("Notifications/$taskName").set(null);
  //   } catch (E) {}
  // }

  // archiveSoloTask(SoloTask st) async {
  //   try {
  //     await soloTasksRef.child('${st.id}/"archived"').set(true);
  //   } catch (E) {}
  // }

  // archiveCollabTask(CollabTask ct) async {
  //   try {
  //     await personalUserRef.child("CollabTasks/${ct.id}").set(true);
  //   } catch (E) {}
  // }

  // isCollabTaskArchived(CollabTask ct) async {
  //   print("is it achived?");
  //   bool isArchived = false;
  //   try {
  //     await personalUserRef.child("CollabTasks/${ct.id}").once().then((data) {
  //       isArchived = data.value;
  //     });
  //   } catch (e) {
  //     isArchived = false;
  //   }
  //   print(isArchived);

  //   return isArchived;
  // }
}
