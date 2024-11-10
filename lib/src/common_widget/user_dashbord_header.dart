import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket/src/fetuers/authentication/screens/login/login.dart';
import 'package:cricket/src/fetuers/authentication/screens/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cricket/src/constants/colors.dart';
import 'package:cricket/src/constants/text_string.dart';

class UserDashboardHeader extends StatefulWidget {
  final double shrinkOffset;

  const UserDashboardHeader({super.key, required this.shrinkOffset});

  @override
  _UserDashboardHeaderState createState() => _UserDashboardHeaderState();
}

class _UserDashboardHeaderState extends State<UserDashboardHeader>
    with SingleTickerProviderStateMixin {
  String? userName;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _getUserData();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['firstName'];
        });
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1 - (widget.shrinkOffset / 300).clamp(0.0, 1.0);
    _controller.value = 1 - scale;

    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight),
      child: Opacity(
        opacity: _opacityAnimation.value,
        child: Transform.scale(
          scale: scale,
          child: Container(
            decoration: const BoxDecoration(
              color: darkColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppName,
                    style: TextStyle(
                      color: lightColor,
                      fontSize: 30,
                      fontFamily: X,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserProfilePage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: cardBGColor,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Row(
                            children: [
                              Text(
                                userName != null
                                    ? userName!.length > 10
                                        ? userName!.substring(0, 10)
                                        : userName!
                                    : 'Hello User',
                                style: const TextStyle(
                                  color: lightColor,
                                  fontSize: 15,
                                  fontFamily: String.fromEnvironment(name),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.person,
                                color: lightColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.login_outlined, color: lightColor),
                        onPressed: _signOut,
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
}
