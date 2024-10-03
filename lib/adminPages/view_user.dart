import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_view/adminPages/ArgsClass.dart';
import 'package:http/http.dart' as http;
import 'package:smart_view/constants.dart' as constants;
import 'dart:convert';

import '../model/users.dart';

class ViewUser extends StatefulWidget {
  @override
  const ViewUser({super.key});

  @override
  _ViewUserState createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  late String realName;
  late VoidCallback refreshFunc;

  //Initialize a empty user to store variables needed
  Users viewingUser = Users(
      username: "",
      emailAddress: "",
      name: "",
      phoneNumber: int.parse("0"),
      password: "",
      salt: "",
      isAdmin: int.parse("0"));

  bool isEnabled = false;

  @override
  void dispose() {
    _userName.dispose();
    _phoneNumber.dispose();
    _emailAddress.dispose();
    super.dispose();
    refreshFunc();
  }

  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('One or more of the fields are empty.'),
                Text(
                    'Please ensure all fields are filled before trying again.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeletionConfirmation() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm deletion?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to delete this user?'),
                Text('THIS ACTION CANNOT BE UNDONE.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                deleteEntry();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void checkIfEmptyAndUpdate() async {
    if ((_userName.text.isEmpty) ||
        (_emailAddress.text.isEmpty) ||
        (_phoneNumber.text.isEmpty)) {
      _showErrorDialog();
    } else {
      final response = await http.put(
        Uri.parse(constants.fetchSpecificUser + realName.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "username": _userName.text,
          "email_address": _emailAddress.text,
          "name": viewingUser.name,
          "phone_number": _phoneNumber.text,
          "password": viewingUser.password,
          "salt": viewingUser.salt,
          "is_admin": viewingUser.isAdmin.toString()
        }),
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
      }
    }
  }

  void deleteEntry() async {
    final response = await http.delete(
      Uri.parse(constants.fetchSpecificUser + realName.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserArgs;
    var user = args.user;
    refreshFunc = args.voidFunc;

    //Init the values
    realName = user.name;
    String username = user.username;
    String emailAddress = user.emailAddress;
    String phoneNumber = user.phoneNumber.toString();
    _userName.text = username;
    _phoneNumber.text = phoneNumber;
    _emailAddress.text = emailAddress;
    viewingUser.name = user.name;
    viewingUser.password = user.password;
    viewingUser.salt = user.salt;
    viewingUser.isAdmin = user.isAdmin;

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
            Center(
              child: Text(
                "Viewing $realName",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff343434),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: TextField(
                      controller: _userName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                      onChanged: (String value) {
                        username = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: TextField(
                      controller: _phoneNumber,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Phone Number",
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        phoneNumber = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: TextField(
                      controller: _emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email Address",
                      ),
                      onChanged: (String value) {
                        emailAddress = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: _buildAddButton(),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Widget _buildAddButton() {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700),
                onPressed: checkIfEmptyAndUpdate,
                child: const Text('Update User'))),
        Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 179, 58, 58)),
                onPressed: _showDeletionConfirmation,
                child: const Text('Delete User')))
      ],
    );
  }
}
