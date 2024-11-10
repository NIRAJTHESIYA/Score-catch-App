import 'package:cricket/src/common_widget/footer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cricket/src/common_widget/header.dart';
import 'package:cricket/src/constants/animation.dart';
import 'package:cricket/src/constants/image_string.dart';
import 'package:cricket/src/constants/colors.dart';
import 'package:cricket/src/constants/text_string.dart';
import 'package:cricket/src/fetuers/authentication/screens/dashbord/home.dart';
import 'package:cricket/src/fetuers/authentication/screens/registration/registration.dart';
import '../forgot_password/forgot.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  String? _passwordError;

  Future<void> login() async {
    if (_formKey.currentState?.validate() ?? false) {
      emailController.text.trim();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.push(
          context,
          AnimatSlide.createSlideTransition(
            currentPage: widget,
            newPage: const HomePage(),
            currentPageBegin: Offset.zero,
            currentPageEnd: const Offset(0.0, 1.0),
            newPageBegin: const Offset(0.0, -1.0),
            newPageEnd: Offset.zero,
            curve: Curves.easeInOut,
          ),
        );
      } catch (e) {
        setState(() {
          _passwordError = 'Incorrect email or password';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Header(
              title: "Login",
              backgroundColor: darkColor,
            ),
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      style: const TextStyle(
                        fontFamily: 'Regular',
                        letterSpacing: 1,
                        fontSize: 20,
                        color: darkColor,
                      ),
                      cursorColor: darkColor,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.lock_outline),
                        ),
                        labelText: 'Password',
                        labelStyle: labelStyle,
                        hintText: 'Enter your password',
                        hintStyle: hintTextStyle,
                        fillColor: lightColor,
                        filled: true,
                        border: outlineInputBorderbox,
                        focusedBorder: outlineInputBorderFocus,
                        errorStyle: errorStyle,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: darkColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        errorText: _passwordError,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            AnimatSlide.createSlideTransition(
                              currentPage: widget,
                              newPage: const ForgotPasswordPage(),
                              currentPageBegin: Offset.zero,
                              currentPageEnd: const Offset(0.0, 1.0),
                              newPageBegin: const Offset(0.0, -1.0),
                              newPageEnd: Offset.zero,
                              curve: Curves.easeInOut,
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 18,
                            color: greenColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: darkColor,
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: lightColor,
                          fontSize: 25,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Regular',
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(thickness: 1, color: darkColor),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Or Login With",
                            style: TextStyle(
                              color: darkColor,
                              fontFamily: 'Regular',
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(thickness: 1, color: darkColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            google,
                            height: 24,
                          ),
                          label: const Text(
                            "Google",
                            style: TextStyle(
                              color: lightColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkColor,
                            foregroundColor: darkColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            facebook,
                            height: 24,
                          ),
                          label: const Text(
                            "Facebook",
                            style: TextStyle(
                              color: lightColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkColor,
                            foregroundColor: darkColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(
        simpleText: "Don't have an account? ",
        navigateText: "Register",
        currentPage: widget,
        navigatePage: const RegistrationPage(),
        Direction: -1,
      ),
    );
  }
}
