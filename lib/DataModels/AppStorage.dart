import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:plantApp/DataModels/Listing.dart';
import 'package:plantApp/DataModels/UserInfo.dart';
import 'dart:io';
import 'package:random_string/random_string.dart';

class AppStorage {
  FirebaseStorage fStorage;
  StorageReference imagesRef;

  AppStorage() {
    fStorage = FirebaseStorage.instance;

    imagesRef = fStorage.ref().child('images');
  }

  uploadFileAndRetrieveLink(File file) async {
    StorageUploadTask uploadTask =
        imagesRef.child(randomAlphaNumeric(26)).putFile(file);
    StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    String url = (await downloadUrl.ref.getDownloadURL());

    return url;
  }
}
