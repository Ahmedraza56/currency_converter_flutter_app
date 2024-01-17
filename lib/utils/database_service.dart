import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'userdata_services.dart';

class DatabaseService {
  static final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  static Future<void> getUserData(BuildContext context, String uid) async {
    try {
      DatabaseEvent event = await _databaseReference.child("Signup Database").child(uid).once();
      DataSnapshot dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic>? userData = dataSnapshot.value as Map<dynamic, dynamic>?;

        if (userData != null) {
          String name = userData["Name"] ?? "";
          String email = userData["Email"] ?? "";
          String phone = userData["Phone No"] ?? "";

          // Set user data using the provider
          Provider.of<UserDataProvider>(context, listen: false)
              .setUserData(name: name, email: email, phone: phone);
        }
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }
}
