import 'package:firebase_auth/firebase_auth.dart';
import 'package:cricket/src/common_widget/footer.dart';
import 'package:cricket/src/common_widget/header.dart';
import 'package:cricket/src/constants/colors.dart';
import 'package:cricket/src/constants/text_string.dart';
import 'package:cricket/src/fetuers/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<void> sendPasswordResetEmail() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
        _showSuccessDialog();
      } catch (e) {
        _showErrorSnackbar(e.toString());
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Email Sent"),
        content: Text(
            "A password reset link has been sent to ${emailController.text.trim()}. Please check your email."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackbar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Header(title: "Reset Password", backgroundColor: darkColor),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      style: const TextStyle(
                        fontFamily: 'Regular',
                        letterSpacing: 1,
                        fontSize: 20,
                        color: darkColor,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.email_outlined),
                        ),
                        labelText: 'Email',
                        labelStyle: labelStyle,
                        hintText: 'Enter your email',
                        hintStyle: hintTextStyle,
                        fillColor: lightColor,
                        filled: true,
                        border: outlineInputBorderbox,
                        focusedBorder: outlineInputBorderFocus,
                        errorStyle: errorStyle,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: sendPasswordResetEmail,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: darkColor,
                      ),
                      child: const Text(
                        "Send Reset Email",
                        style: TextStyle(
                          color: lightColor,
                          fontSize: 25,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                          fontFamily: R,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(
        simpleText: "Remembered your password? ",
        navigateText: "Login",
        currentPage: widget,
        navigatePage: const LoginPage(),
        Direction: -1,
      ),
    );
  }
}
