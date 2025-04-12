import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String username;
  final String email;
  final String studentId;
  final Timestamp? createdAt;

  UserProfile({
    required this.uid,
    required this.username,
    required this.email,
    required this.studentId,
    this.createdAt,
  });

  // Factory constructor to create a UserProfile from a Firestore Map
  factory UserProfile.fromMap(String uid, Map<String, dynamic> data) {
    return UserProfile(
      uid: uid,
      username: data['username'] as String? ?? 'N/A',
      email: data['email'] as String? ?? 'N/A',
      studentId: data['studentId'] as String? ?? 'N/A',
      createdAt: data['createdAt'] as Timestamp?,
    );
  }

  // Convert UserProfile to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'studentId': studentId,
      'createdAt': createdAt,
    };
  }

  // Create a copyWith method for easy updates
  UserProfile copyWith({
    String? username,
    String? email,
    String? studentId,
    Timestamp? createdAt,
  }) {
    return UserProfile(
      uid: uid,
      username: username ?? this.username,
      email: email ?? this.email,
      studentId: studentId ?? this.studentId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}