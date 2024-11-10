import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cricket/src/common_widget/footer.dart';
import 'package:cricket/src/common_widget/header.dart';
import 'package:cricket/src/constants/colors.dart';
import 'package:cricket/src/constants/input_field.dart';
import 'package:cricket/src/constants/text_string.dart';
import 'package:cricket/src/fetuers/authentication/screens/login/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? emailErrorMessage;

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        emailErrorMessage = null;
      });

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        String fullName = fullNameController.text.trim();
        String formattedName =
            fullName[0].toUpperCase() + fullName.substring(1);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'firstName': formattedName,
        });

        _showSuccessDialog();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          setState(() {
            emailErrorMessage = 'Email is already registered';
          });
        } else {
          _showErrorSnackbar(e.message ?? 'An error occurred');
        }
      } catch (e) {
        _showErrorSnackbar('An error occurred');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(
              'Registration successful for ${fullNameController.text.trim()}!'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Header(title: "Sign Up", backgroundColor: darkColor),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: fullNameController,
                      cursorColor: dangerColor,
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          letterSpacing: 1,
                          fontSize: 20,
                          color: darkColor),
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: labelStyle,
                        hintText: 'Enter your Name',
                        hintStyle: const TextStyle(
                          fontFamily: "Regular",
                          color: darkColor,
                          fontSize: 20,
                          letterSpacing: 1,
                        ),
                        fillColor: lightColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.person_outline_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        errorStyle: const TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 18,
                          color: dangerColor,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      cursorColor: dangerColor,
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          letterSpacing: 1,
                          fontSize: 20,
                          color: darkColor),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: labelStyle,
                        hintText: 'Enter your email',
                        hintStyle: const TextStyle(
                          fontFamily: "Regular",
                          color: darkColor,
                          fontSize: 20,
                          letterSpacing: 1,
                        ),
                        fillColor: lightColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        errorText: emailErrorMessage,
                        errorStyle: const TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 18,
                          color: dangerColor,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      controller: passwordController,
                      labelText: 'Password',
                      hintText: 'Set Password',
                      prefixIcon: Icons.lock_open,
                      obscureText: !_passwordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      controller: confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: !_confirmPasswordVisible,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: register,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 80),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: darkColor,
                            ),
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: lightColor,
                                fontSize: 25,
                                letterSpacing: 3,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Regular',
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Footer(
        simpleText: "Already have an Account? ",
        navigateText: "Login",
        currentPage: widget,
        navigatePage: const LoginPage(),
        Direction: 1,
      ),
    );
  }
}
