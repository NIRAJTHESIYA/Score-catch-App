import 'package:flutter/material.dart';

class AnimatSlide {
  static Route createSlideTransition({
    required Widget currentPage,
    required Widget newPage,
    required Offset currentPageBegin,
    required Offset currentPageEnd,
    required Offset newPageBegin,
    required Offset newPageEnd,
    Duration duration = const Duration(milliseconds: 1500),
    Curve curve = Curves.easeInOut,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => newPage,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var currentPageTween = Tween<Offset>(
          begin: currentPageBegin,
          end: currentPageEnd,
        ).chain(CurveTween(curve: curve));

        var newPageTween = Tween<Offset>(
          begin: newPageBegin,
          end: newPageEnd,
        ).chain(CurveTween(curve: curve));

        return Stack(
          children: [
            SlideTransition(
              position: animation.drive(currentPageTween),
              child: currentPage,
            ),
            SlideTransition(
              position: animation.drive(newPageTween),
              child: newPage,
            ),
          ],
        );
      },
    );
  }
}
