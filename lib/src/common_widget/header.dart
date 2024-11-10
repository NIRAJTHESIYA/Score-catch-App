import 'package:flutter/material.dart';
import 'package:cricket/src/constants/colors.dart';
import 'package:cricket/src/constants/text_string.dart';

class Header extends StatefulWidget {
  final String title;
  final Color backgroundColor;

  const Header({
    Key? key,
    required this.title,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<Offset> _subtitleSlideAnimation;

  // Flag to check if animation has already been performed
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _subtitleSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation only if it hasn't been performed yet
    if (!_hasAnimated) {
      _animationController.forward();
      _hasAnimated = true;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
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
                SlideTransition(
                  position: _titleSlideAnimation,
                  child: const Text(
                    AppName,
                    style: TextStyle(
                      color: lightColor,
                      fontSize: 45,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: X,
                    ),
                  ),
                ),
                SlideTransition(
                  position: _subtitleSlideAnimation,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: lightColor,
                      fontSize: 35,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontFamily: R,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
