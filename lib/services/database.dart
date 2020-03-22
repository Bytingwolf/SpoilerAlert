import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class DatabaseService {
  // Collection reference

  final CollectionReference foodCollection =
      Firestore.instance.collection('foods');

  Future updateUserData(
      String foodName, String foodType, DateTime expiryDate) async {
    return await foodCollection.document();
  }
}
