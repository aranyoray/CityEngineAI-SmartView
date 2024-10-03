import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_view/settingsPages/settings_password_reset_page.dart';

class SettingsNotificationPage extends StatefulWidget {
  const SettingsNotificationPage({super.key});

  @override
  State<SettingsNotificationPage> createState() =>
      _SettingsNotificationPageState();
}

class _SettingsNotificationPageState extends State<SettingsNotificationPage> {
  // Initial Selected Value
  String dropdownvalue = '10 mins';

  // List of items in our dropdown menu
  var items = [
    '10 mins',
    '15 mins',
    '30 mins',
  ];

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
                "Notification",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff343434),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Time interval button
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsPasswordResetPage()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Text(
                      "Notifications intervals",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff343434),
                      ),
                    ),
                    const Spacer(),
                    DropdownButton(
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff343434),
                      ),
                      // Initial Value
                      value: dropdownvalue,
                      // Array list of items
                      items: items.map(
                        (String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        },
                      ).toList(),
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            dropdownvalue = newValue!;
                          },
                        );
                      },
                    ),
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
