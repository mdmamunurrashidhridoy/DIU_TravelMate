import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tarvel_mate/pages/login.dart';
import 'package:tarvel_mate/utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Successful'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome! Signup & Profile Creation Successful!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Go to Login Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscurePass = true;
  bool _obscureComPass = true;
  bool _acceptTrams = false;
  bool _isLoading = false;
  final formkey = GlobalKey<FormState>();
  bool _showTermsError = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final studentIdController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    studentIdController.dispose();
    super.dispose();
  }

  Future<void> createUserProfile(User user) async {
    if (user == null) return;

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'username': usernameController.text.trim(),
        'studentId': studentIdController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("User profile created successfully");
    } catch (e) {
      print("Error creating user profile: $e");
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to create user profile: $e',
      );
    }
  }

  Future<void> signUpUser(BuildContext context) async {
    setState(() {
      _showTermsError = false;
    });
    
    if (!(formkey.currentState?.validate() ?? false)) return;
    
    if (!_acceptTrams) {
      setState(() => _showTermsError = true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      if (userCredential.user != null) {
        await createUserProfile(userCredential.user!);
        
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Authentication failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (context.mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Username Field
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Iconsax.user_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a username';
                      }
                      if (value.trim().length < 3) {
                        return 'Username must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Email Field
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Student Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Student ID Field
                  TextFormField(
                    controller: studentIdController,
                    decoration: const InputDecoration(
                      labelText: "Student Id",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your Student ID';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePass,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Iconsax.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _obscurePass = !_obscurePass),
                        icon: Icon(
                          _obscurePass
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Confirm Password Field
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _obscureComPass,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Iconsax.lock_1_outline),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _obscureComPass = !_obscureComPass),
                        icon: Icon(
                          _obscureComPass
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Terms and Conditions
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTrams,
                        onChanged: (value) {
                          setState(() {
                            _acceptTrams = value ?? false;
                            if (_acceptTrams) _showTermsError = false;
                          });
                        },
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Terms & Conditions"),
                                content: const SingleChildScrollView(
                                  child: Text("Here are the terms..."),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Close"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              "Accept the terms and conditions.",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (_showTermsError)
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 4.0, bottom: 10.0),
                      child: Text(
                        'You must accept the terms and conditions',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                    ),

                  const SizedBox(height: 15),

                  // Sign Up Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : () => signUpUser(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: FColors.primarypurple,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: FColors.primarypurple.withOpacity(0.5),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ),
                          )
                        : const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}