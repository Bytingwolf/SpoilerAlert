import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class DatabaseService {
  // Collection reference

  final String uid;
  DatabaseService({this.uid});
  final CollectionReference foodCollection =
      Firestore.instance.collection('userId');

  Future updateUserData(
      String foodName, String foodType, DateTime expiryDate) async {
    return await foodCollection.document(uid).setData({
      'name': foodName,
      'type': foodType,
      'expiry date': expiryDate,
    });
  }
}
