import 'package:cricket/src/constants/animation.dart';
import 'package:cricket/src/constants/colors.dart';
import 'package:cricket/src/constants/text_string.dart';
import 'package:cricket/src/fetuers/authentication/screens/dashbord/home.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();

  String? firstNameError;
  String? lastNameError;
  String? mobileError;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User? currentUser;
  String? email;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    email = currentUser?.email;
    _loadUserData();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    mobileController.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    mobileFocusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _loadUserData() async {
    if (currentUser != null) {
      final userDoc =
          await _firestore.collection('users').doc(currentUser!.uid).get();
      if (userDoc.exists) {
        final data =
            userDoc.data() ?? {}; // Use default empty map if data is null

        setState(() {
          firstNameController.text = data['firstName'] ?? '';
          lastNameController.text = data['lastName'] ?? '';
          dobController.text = data['dob'] ?? '';
          mobileController.text = data['mobile'] ?? '';
        });
      } else {
        // Handle case where the document does not exist
        // For example, you might want to create a new document with default values
        await _firestore.collection('users').doc(currentUser!.uid).set({
          'firstName': '',
          'lastName': '',
          'dob': '',
          'mobile': '',
          'email': currentUser!.email,
        }, SetOptions(merge: true));
      }
    }
  }

  Future<void> _saveUserData() async {
    if (currentUser != null) {
      await _firestore.collection('users').doc(currentUser!.uid).set({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'dob': dobController.text,
        'mobile': mobileController.text,
        'email': currentUser!.email,
      }, SetOptions(merge: true));
    }
  }

  void _validateAndSave() {
    setState(() {
      firstNameError = null;
      lastNameError = null;
      mobileError = null;

      if (firstNameController.text.isEmpty) {
        firstNameError = "First name cannot be empty!";
      }

      if (lastNameController.text.isEmpty) {
        lastNameError = "Last name cannot be empty!";
      }

      if (mobileController.text.isEmpty) {
        mobileError = "Mobile number cannot be empty!";
      } else if (mobileController.text.length != 10 ||
          !RegExp(r'^[0-9]+$').hasMatch(mobileController.text)) {
        mobileError = "Mobile number must be 10 digits!";
      }
    });

    if (firstNameError == null &&
        lastNameError == null &&
        mobileError == null) {
      _saveUserData();
    }

    Navigator.push(
      context,
      AnimatSlide.createSlideTransition(
        currentPage: widget,
        newPage: const HomePage(),
        currentPageBegin: Offset.zero,
        currentPageEnd: const Offset(0.0, -1.0),
        newPageBegin: const Offset(0.0, 1.0),
        newPageEnd: Offset.zero,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Profile",
          style: TextStyle(color: seconderyColor),
        ),
        backgroundColor: darkColor,
      ),
      backgroundColor: lightColor,
      body: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Email Address",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: darkColor),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: seconderyColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: darkColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            email ?? '',
                            style:
                                const TextStyle(fontSize: 18, color: darkColor),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          label: "First Name",
                          controller: firstNameController,
                          focusNode: firstNameFocusNode,
                          errorText: firstNameError,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          label: "Last Name",
                          controller: lastNameController,
                          focusNode: lastNameFocusNode,
                          errorText: lastNameError,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Date of Birth",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: darkColor),
                        ),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: TextField(
                                controller: dobController,
                                decoration: InputDecoration(
                                  hintText: "Select your date of birth",
                                  hintStyle: hintTextStyle,
                                  filled: true,
                                  fillColor: seconderyColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: darkColor,
                                      width: 2,
                                    ),
                                  ),
                                  suffixIcon: const Icon(Icons.calendar_today,
                                      color: darkColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          label: "Mobile Number",
                          controller: mobileController,
                          focusNode: mobileFocusNode,
                          errorText: mobileError,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: _validateAndSave,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: darkColor,
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 30, color: seconderyColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppName,
                      style: TextStyle(
                        color: lightColor,
                        fontFamily: B,
                        fontSize: 25,
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: darkColor),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: "Enter your $label",
              hintStyle: hintTextStyle,
              filled: true,
              fillColor: seconderyColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: focusNode.hasFocus ? Colors.red : darkColor,
                  width: 2,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              errorText: errorText,
            ),
          ),
        ),
      ],
    );
  }
}
