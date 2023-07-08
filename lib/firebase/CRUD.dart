import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CRUD {
  final DocumentReference _firestore;

  CRUD(this._firestore);

  Future<void> add({
    required  data,
    required BuildContext context, required DocumentReference<Object?> firestore,
  }) async {
    _firestore
        .set(data)
        .whenComplete(() => print("data added"))
        .onError((error, stackTrace) => print(error));
  }

  
}
