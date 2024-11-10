import 'package:cricket/src/fetuers/authentication/screens/dashbord/home.dart';
import 'package:cricket/src/fetuers/authentication/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cricket/src/constants/colors.dart';
import 'package:cricket/src/constants/text_string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _headerAnimation;
  late Animation<Offset> _bottomBarAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _appNameTextSizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _headerAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _bottomBarAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _appNameTextSizeAnimation = Tween<double>(
      begin: 30.0,
      end: 50.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    // Delay for splash animation before checking authentication
    Future.delayed(const Duration(seconds: 3), () {
      _controller.reverse().then((value) {
        _checkAuthentication();
      });
    });
  }

  void _checkAuthentication() async {
    // Check Firebase authentication state
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      _navigateToHome();
    } else {
      _navigateToLoginPage();
    }
  }

  void _navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SlideTransition(
              position: _headerAnimation,
              child: _buildHeader(context, AppName, darkColor),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(50.0)),
        child: SlideTransition(
          position: _bottomBarAnimation,
          child: Container(
            color: darkColor,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 80.0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                color: darkColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _textFadeAnimation,
                        child: const Text(
                          "Let's get started! ",
                          style: TextStyle(
                            color: lightColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Regular',
                            fontSize: 15,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToLoginPage,
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            color: greenColor,
                            fontFamily: 'Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, String title, Color backgroundColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 30,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome to,",
                  style: TextStyle(
                    color: lightColor,
                    fontSize: 30,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'bold',
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedBuilder(
                  animation: _appNameTextSizeAnimation,
                  builder: (context, child) {
                    return Text(
                      title,
                      style: TextStyle(
                        color: lightColor,
                        fontSize: _appNameTextSizeAnimation.value,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'extrabold',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
  