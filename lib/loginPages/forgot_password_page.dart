// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_view/loginPages/login_page.dart';
import 'package:smart_view/loginPages/reset_link_page.dart';
import 'package:smart_view/settingsPages/settings_password_reset_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff00358f),
          ),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 80),
          // Smartview title
          Text(
            'SmartView',
            style: GoogleFonts.poppins(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),

          //logo
          Image(image: AssetImage('assets/images/security.png')),
          SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter your email and we will send you a link to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF4C4E52),
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(height: 15),

          // username textfield
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       border: Border.all(color: Colors.grey),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 2.0),
          //       child: TextField(
          //         keyboardType: TextInputType.emailAddress,
          //         enableSuggestions: false,
          //         autocorrect: false,
          //         decoration: InputDecoration(
          //           border: InputBorder.none,
          //           prefixIcon: Icon(
          //             Icons.person,
          //             color: Colors.grey,
          //           ),
          //           hintText: 'Email address',
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Email address",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  )),
            ),
          ),
          SizedBox(height: 10),

          //reset button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ButtonTheme(
              minWidth: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ResetLinkPage()));
                },
                color: Color(0xFF00358F),
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  'Reset my password',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ]),
      ),
    );
  }
}
