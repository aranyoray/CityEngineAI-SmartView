// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_view/adminPages/admin_panel.dart';
import 'package:smart_view/constants.dart' as constants;
import 'package:smart_view/loginPages/login_page.dart';
import 'package:smart_view/userPages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkIsLogin();
  }

  checkIsLogin() async {
    await Future.delayed(Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final bool? isLogin = prefs.getBool('isLogin');
    final String? role = prefs.getString('currRole');
    final String username = prefs.getString('currUser').toString();

    redirectPages(isLogin, role, username);
  }

  redirectPages(bool? isLogin, String? role, String username) {
    if (isLogin == false || isLogin == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      if (role == "admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminPage(title: username)),
        );
      } else if (role == "user") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Smartview title
                Text(
                  'SmartView',
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Image(image: AssetImage('assets/images/security.png')),
                SizedBox(height: 50),
                LoadingAnimationWidget.hexagonDots(
                    color: constants.textGrayColour, size: 50),

                //test print delete later
                //Text(name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
