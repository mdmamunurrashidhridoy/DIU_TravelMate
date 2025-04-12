import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarvel_mate/userdata/userprofile.dart';
import 'dart:async';

class UserDataProvider with ChangeNotifier {
  UserProfile? _userProfile;
  StreamSubscription<DocumentSnapshot>? _userSubscription;

  UserProfile? get userProfile => _userProfile;
  bool get isLoggedIn => _userProfile != null;

  void startUserUpdates() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _userSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data()!;
        _userProfile = UserProfile.fromMap(user.uid, data);
        notifyListeners();
        print("User profile updated via stream");
      }
    });
  }

  void stopUserUpdates() {
    _userSubscription?.cancel();
    _userSubscription = null;
  }

  Future<void> fetchUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _userProfile = null;
      notifyListeners();
      print("UserDataProvider: No user logged in.");
      return;
    }

    _userProfile = null;
    notifyListeners(); // Notify that loading started

    try {
      final userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userSnap.exists && userSnap.data() != null) {
        final data = userSnap.data()!;
        _userProfile = UserProfile.fromMap(user.uid, data);
        print("UserDataProvider: User profile loaded");
      } else {
        print("UserDataProvider: User document not found for ${user.uid}");
      }
      
      notifyListeners();
    } catch (e) {
      _userProfile = null;
      print("UserDataProvider: Error fetching user data: $e");
      notifyListeners();
    }
  }

  void clearUserData() {
    _userProfile = null;
    notifyListeners();
    print("UserDataProvider: User data cleared.");
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}