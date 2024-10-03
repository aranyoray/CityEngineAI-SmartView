import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../loginPages/login_page.dart';

class SettingsPasswordResetPage extends StatefulWidget {
  const SettingsPasswordResetPage({super.key});

  @override
  State<SettingsPasswordResetPage> createState() =>
      _SettingsPasswordResetPageState();
}

class _SettingsPasswordResetPageState extends State<SettingsPasswordResetPage> {
  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();

  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        // Back icon
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff00358f),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // Title text
          Center(
            child: Text(
              'Reset Password',
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: const Color(0xff343434),
              ),
            ),
          ),

          const SizedBox(height: 45),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Current Password
                  TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Current Password',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your current password';
                        }

                        if (value != '123') {
                          return 'Invalid current password';
                        }
                        // Return null if the entered password is valid
                        return null;
                      }),

                  const SizedBox(height: 25),

                  // New Password
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'New Password',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }

                      if (value.trim().length < 8) {
                        return 'Password must be at least 8 characters in length';
                      }

                      // Return null if the entered password is valid
                      return null;
                    },
                    onChanged: (value) => _password = value,
                  ),

                  const SizedBox(height: 25),

                  // Confirm New Password
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Confirm New Password',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }

                      if (value != _password) {
                        return 'Confimation password does not match the entered password';
                      }

                      // Return null if the entered password is valid
                      return null;
                    },
                    onChanged: (value) => _confirmPassword = value,
                  ),

                  const SizedBox(height: 35),

                  // Save button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 85.0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          // Check if all fields have valid inputs before submission
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                          }
                          ;
                        },
                        color: const Color(0xFF00358F),
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
