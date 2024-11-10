import 'package:cricket/src/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:cricket/src/constants/colors.dart';
import 'package:cricket/src/constants/animation.dart';

class Footer extends StatelessWidget {
  final String simpleText;
  final String navigateText;
  final Widget currentPage;
  final Widget navigatePage;
  final int Direction;

  const Footer({
    Key? key,
    required this.simpleText,
    required this.navigateText,
    required this.currentPage,
    required this.navigatePage,
    required this.Direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(50.0)),
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
                  Text(
                    simpleText,
                    style: const TextStyle(
                      color: lightColor,
                      fontFamily: R,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          AnimatSlide.createSlideTransition(
                            currentPage: currentPage,
                            newPage: navigatePage,
                            currentPageBegin: Offset.zero,
                            currentPageEnd:
                                Offset(0.0, Direction == 1 ? 1.0 : -1.0),
                            newPageBegin:
                                Offset(0.0, Direction == 1 ? -1.0 : 1.0),
                            newPageEnd: Offset.zero,
                            curve: Curves.easeInOut,
                          ),
                        );
                      },
                      child: Text(
                        navigateText,
                        style: const TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 20,
                          color: greenColor,
                        ),
                      ),
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
