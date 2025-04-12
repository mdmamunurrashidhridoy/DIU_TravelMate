import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart'; // If using provider for email prefill

// Import your provider if you want to prefill email
import 'package:tarvel_mate/userdata/userdataprovider.dart';
import 'package:tarvel_mate/userdata/userprofile.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>(); // Key for validating the form
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false; // To show loading indicator on the button

  @override
  void initState() {
    super.initState();
    // --- Optional: Prefill email if user is logged in ---
    // Use WidgetsBinding to ensure context is available and provider is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use context.read as we only need the value once initially
      final userProvider = context.read<UserDataProvider>();
      if (userProvider.isLoggedIn && userProvider.userProfile?.email != null) {
        _emailController.text = userProvider.userProfile!.email;
      }
      // Alternatively, get email directly from FirebaseAuth if provider isn't setup globally yet
      // else if (FirebaseAuth.instance.currentUser?.email != null) {
      //   _emailController.text = FirebaseAuth.instance.currentUser!.email!;
      // }
    });
    // ----------------------------------------------------
  }


  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    // Validate the form first
    if (!_formKey.currentState!.validate()) {
      return; // If validation fails, do nothing
    }

    // Show loading indicator
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final message = _messageController.text.trim();
    final userId = FirebaseAuth.instance.currentUser?.uid; // Get current user ID if logged in

    try {
      // Add data to Firestore 'feedback' collection
      await FirebaseFirestore.instance.collection('feedback').add({
        'email': email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(), // Add a server timestamp
        'userId': userId, // Store user ID (null if not logged in, though rules prevent this)
        'status': 'New', // Optional: Add a status field
      });

      // Show success message
      if (mounted) { // Check if the widget is still in the tree
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Feedback submitted successfully! Thank you.'),
            backgroundColor: Colors.green,
          ),
        );
        // Clear the fields after successful submission
        _emailController.clear();
        _messageController.clear();
        // Optional: Navigate back
        // Navigator.pop(context);
      }
    } catch (e) {
      print("Error submitting feedback: $e");
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit feedback: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      // Hide loading indicator regardless of success/failure
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Feedback'),
      ),
      body: SingleChildScrollView( // Allows scrolling if content overflows
        padding: const EdgeInsets.all(16.0),
        child: Form( // Use a Form widget for validation
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Make button stretch
            children: <Widget>[
              Text(
                "We appreciate your feedback! Please let us know your thoughts.",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // --- Email Field ---
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Your Email Address',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email address';
                  }
                  // Basic email format check
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null; // Return null if valid
                },
              ),
              const SizedBox(height: 16),

              // --- Message Field ---
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Your Feedback / Message',
                  hintText: 'Enter your message here...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true, // Better alignment for multi-line
                ),
                maxLines: 5, // Allow multiple lines for the message
                textInputAction: TextInputAction.newline, // Suggest multi-line input
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your feedback message';
                  }
                  if (value.trim().length < 10) {
                    return 'Please provide a bit more detail (min 10 chars)';
                  }
                  return null; // Return null if valid
                },
              ),
              const SizedBox(height: 24),

              // --- Submit Button ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                  // backgroundColor: Theme.of(context).colorScheme.primary, // Use theme color
                  // foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                // Disable button and show loading indicator while submitting
                onPressed: _isLoading ? null : _submitFeedback,
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                        ),
                      )
                    : const Text('Submit Feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}