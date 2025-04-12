import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarvel_mate/utils/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:tarvel_mate/userdata/userdataprovider.dart';
import 'package:icons_plus/icons_plus.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  bool _isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUserWithEmailAndPassword(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Authenticate with Firebase Auth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Fetch user data
      await Provider.of<UserDataProvider>(context, listen: false).fetchUserData();

      // Navigate to home
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/nav',
          (Route<dynamic> route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e);
    } catch (e) {
      _handleGenericError(context, e);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleAuthError(BuildContext context, FirebaseAuthException e) {
    Provider.of<UserDataProvider>(context, listen: false).clearUserData();
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_getErrorMessage(e)),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleGenericError(BuildContext context, dynamic e) {
    Provider.of<UserDataProvider>(context, listen: false).clearUserData();
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found for this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      default:
        return 'Login failed: ${e.message}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Iconsax.direct_right_outline),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Iconsax.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText 
                            ? Icons.visibility_off_outlined 
                            : Icons.visibility_outlined),
                        onPressed: () => setState(() => _obscureText = !_obscureText),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                      child: const Text("Forgot Password?", style: TextStyle(fontFamily: 'DMSans')),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : () => loginUserWithEmailAndPassword(context),
                    style: _loginButtonStyle(),
                    child: _isLoading 
                        ? _loadingIndicator() 
                        : const Text("Login", style: TextStyle(fontSize: 18, fontFamily: 'DMSans')),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?", style: TextStyle(fontFamily: 'DMSans')),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/signup'),
                        child: const Text("Sign Up", style: TextStyle(fontFamily: 'DMSans')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  ButtonStyle _loginButtonStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: FColors.primarypurple,
      foregroundColor: Colors.white,
      disabledBackgroundColor: FColors.primarypurple.withOpacity(0.5),
    );
  }

  Widget _loadingIndicator() {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2.0,
      ),
    );
  }
}