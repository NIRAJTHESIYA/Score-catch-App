// lib/constants/text_string.dart

import 'package:flutter/material.dart';
import 'colors.dart';

const String AppName = "Score Catch";
const String name = "Cricket Catch";
const String tagLineName = "Show online Live Score in your Zone..";

const String T = "thin";
const String L = "light";
const String M = "medium";
const String R = "Regular";
const String B = "bold";
const String X = "extrabold";
const String ST = "S-thin";
const String SL = "S-light";
const String SM = "S-medium";
const String SR = "S-Regular";
const String SB = "S-bold";
const String SX = "S-extrabold";

const TextStyle InputTextStyle = TextStyle(
  fontFamily: R,
  letterSpacing: 1,
  fontSize: 20,
  color: darkColor,
);

const TextStyle hintTextStyle = TextStyle(
  fontFamily: L,
  fontSize: 16,
  color: darkColor,
);

const TextStyle labelStyle = TextStyle(
  fontFamily: R,
  color: darkColor,
  fontSize: 20,
  letterSpacing: 2,
  fontWeight: FontWeight.bold,
);

OutlineInputBorder outlineInputBorderbox = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: const BorderSide(
    color: darkColor,
    width: 1.0,
  ),
);

OutlineInputBorder outlineInputBorderFocus = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: const BorderSide(
    color: darkColor,
    width: 2.0,
  ),
);

const TextStyle errorStyle = TextStyle(
  fontFamily: R,
  fontSize: 15,
  color: dangerColor,
);
