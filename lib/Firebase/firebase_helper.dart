import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kings_connect/models/user_model.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class FirebaseHelper {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  // Upload profile image to Firebase Storage
  Future<String> uploadProfileImage(File imageFile, String userId) async {
    String fileName = basename(imageFile.path);
    Reference ref = _storage.ref().child('profile_images/$userId/$fileName');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  // Save user data in Firestore
  Future<void> saveUserData(UserModel user, String userId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(user.toMap());
  }

  // Get user data from Firestore
  Future<UserModel?> getUserData(String userId) async {
  final doc = await _firestore.collection('users').doc(userId).get();
  return doc.exists ? UserModel.fromMap(doc.data()!) : null;
}
}
