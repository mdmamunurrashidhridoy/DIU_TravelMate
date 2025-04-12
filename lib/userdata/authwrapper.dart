import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:tarvel_mate/pages/welcome.dart';
import 'package:tarvel_mate/pages/design_tm.dart';
import 'package:tarvel_mate/userdata/userdataprovider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Initialize auth state listener
    _setupAuthListener();
  }

  void _setupAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
      
      if (user != null) {
        // User is logged in
        print("AuthWrapper: User logged in (${user.uid})");
        userDataProvider.startUserUpdates(); // Start listening to user updates
      } else {
        // User is logged out
        print("AuthWrapper: User logged out");
        userDataProvider.stopUserUpdates(); // Stop listening to updates
        userDataProvider.clearUserData(); // Clear any remaining data
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Handle loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Handle error state
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Authentication error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final user = snapshot.data;
        final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);

        // User is logged in
        if (user != null) {
          print("AuthWrapper: User logged in (${user.uid})");

          // Initialize user data if needed
          if (!userDataProvider.isLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              userDataProvider.fetchUserData(); // Single call to fetch all data
            });
          }

          return const NavBottom();
        } 
        // User is not logged in
        else {
          print("AuthWrapper: User not logged in");
          return const Welcome();
        }
      },
    );
  }
}