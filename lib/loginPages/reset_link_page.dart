import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';

class ResetLinkPage extends StatefulWidget {
  const ResetLinkPage({super.key});

  @override
  State<ResetLinkPage> createState() => _ResetLinkPageState();
}

class _ResetLinkPageState extends State<ResetLinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          const SizedBox(height: 80),
          // Smartview title
          Text(
            'SmartView',
            style: GoogleFonts.poppins(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          //logo
          const Image(image: AssetImage('assets/images/security.png')),
          const SizedBox(height: 40),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Password reset email sent!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF4C4E52),
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 15),

          //reset button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ButtonTheme(
              minWidth: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                color: const Color(0xFF00358F),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: const Text(
                  'Back to login',
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
    );
  }
}
