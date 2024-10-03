import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_view/loginPages/login_page.dart';
import 'package:smart_view/settingsPages/settings_page_account.dart';
import 'package:smart_view/settingsPages/settings_page_notification.dart';
import 'package:smart_view/settingsPages/settings_password_reset_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<Null> removeSharedPrefUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.remove('currName');
      pref.remove('currUser');
      pref.remove('currRole');
      pref.setBool('isLogin', false);
    });
  }

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
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: ListView(
          children: [
            // Title text
            Center(
              child: Text(
                "Settings",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff343434),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Account button
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsAccountPage()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 10),
                    Text(
                      "Account",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff343434),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff343434),
                    )
                  ],
                ),
              ),
            ),

            const Divider(height: 20, thickness: 2),

            const SizedBox(height: 10),

            // Notification button
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsNotificationPage()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    const Icon(Icons.notifications),
                    const SizedBox(width: 10),
                    Text(
                      "Notification",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff343434),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff343434),
                    )
                  ],
                ),
              ),
            ),

            const Divider(height: 20, thickness: 2),

            const SizedBox(height: 10),

            // Logout button
            GestureDetector(
              onTap: () {
                removeSharedPrefUser();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                const LoginPage()), (Route<dynamic> route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    const Icon(Icons.logout),
                    const SizedBox(width: 10),
                    Text(
                      "Logout",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff343434),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff343434),
                    )
                  ],
                ),
              ),
            ),

            const Divider(height: 20, thickness: 2),
          ],
        ),
      ),
    );
  }
}
