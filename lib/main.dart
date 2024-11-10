import 'package:firebase_core/firebase_core.dart';
import 'package:cricket/src/constants/colors.dart';
import 'package:cricket/src/constants/text_string.dart';
import 'package:cricket/src/fetuers/authentication/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: X, fontSize: 96),
          displayMedium: TextStyle(fontFamily: M, fontSize: 60),
          displaySmall: TextStyle(fontFamily: M, fontSize: 48),
          headlineMedium: TextStyle(fontFamily: B, fontSize: 34),
          headlineSmall: TextStyle(fontFamily: R, fontSize: 24),
          titleLarge: TextStyle(fontFamily: X, fontSize: 20),
          bodyLarge: TextStyle(fontFamily: X, fontSize: 16),
          bodyMedium: TextStyle(fontFamily: B, fontSize: 14),
          bodySmall: TextStyle(fontFamily: R, fontSize: 12),
          labelLarge: TextStyle(fontFamily: R, fontSize: 14),
          labelSmall: TextStyle(fontFamily: M, fontSize: 10),
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: darkColor),
      ),
      home: const SplashScreen(),
    );
  }
}