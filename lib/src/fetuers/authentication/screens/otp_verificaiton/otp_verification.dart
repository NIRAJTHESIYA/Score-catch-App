import 'package:cricket/src/constants/colors.dart';
import 'package:cricket/src/fetuers/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: darkColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: const Stack(
                children: [
                  Positioned(
                    left: 30,
                    bottom: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "OTP Verification",
                          style: TextStyle(
                            color: lightColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'bold',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(
                children: [
                  const Text(
                    "Enter the 4-digit code sent to your number",
                    style: TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: darkColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOtpInputField(
                          _otpController1, _focusNode1, _focusNode2),
                      _buildOtpInputField(
                          _otpController2, _focusNode2, _focusNode3),
                      _buildOtpInputField(
                          _otpController3, _focusNode3, _focusNode4),
                      _buildOtpInputField(_otpController4, _focusNode4, null),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Handle OTP verification here
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: darkColor,
                    ),
                    child: const Text(
                      "Verify",
                      style: TextStyle(
                        color: lightColor,
                        fontSize: 25,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'bold',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
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
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: lightColor,
                        fontFamily: "Regular",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const LoginPage(),
                            transitionDuration:
                                const Duration(milliseconds: 800),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var loginBegin = Offset.zero;
                              var loginEnd = const Offset(0.0, -1.0);
                              var registerBegin = const Offset(0.0, 1.0);
                              var registerEnd = Offset.zero;
                              var curve = Curves.easeInOut;

                              var loginTween =
                                  Tween(begin: loginBegin, end: loginEnd)
                                      .chain(CurveTween(curve: curve));
                              var registerTween =
                                  Tween(begin: registerBegin, end: registerEnd)
                                      .chain(CurveTween(curve: curve));

                              return Stack(
                                children: [
                                  SlideTransition(
                                    position: animation.drive(loginTween),
                                    child: this.widget,
                                  ),
                                  SlideTransition(
                                    position: animation.drive(registerTween),
                                    child: child,
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: greenColor,
                          fontFamily: "Regular",
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
    );
  }

  Widget _buildOtpInputField(TextEditingController controller,
      FocusNode currentFocus, FocusNode? nextFocus) {
    return SizedBox(
      width: 60,
      child: TextFormField(
        controller: controller,
        focusNode: currentFocus,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'bold',
        ),
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greenColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        onFieldSubmitted: (value) {
          if (nextFocus == null) {
            // All digits entered, do OTP verification logic here.
          }
        },
      ),
    );
  }
}
