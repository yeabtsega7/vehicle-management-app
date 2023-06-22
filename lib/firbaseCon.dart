import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class firebaseCone {
  static CollectionReference<Map<String, dynamic>> usersRef =
      FirebaseFirestore.instance.collection('users');

  static CollectionReference<Map<String, dynamic>> officeManagerRef =
      FirebaseFirestore.instance.collection('officeManager');

  static CollectionReference<Map<String, dynamic>> fleetManagerRef =
      FirebaseFirestore.instance.collection('fleetManager');

  static CollectionReference<Map<String, dynamic>> driverRef =
      FirebaseFirestore.instance.collection('driver');

  static CollectionReference<Map<String, dynamic>> dispatcherRef =
      FirebaseFirestore.instance.collection('dispatcher');

  static CollectionReference<Map<String, dynamic>> serviceRef =
      FirebaseFirestore.instance.collection('service');

  static CollectionReference<Map<String, dynamic>> vehiclesRef =
      FirebaseFirestore.instance.collection('vechile');

  static String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
}
