import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto/crypto.dart';
import 'package:smart_view/model/users.dart';
import 'dart:convert';
import 'dart:math';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _realName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isEnabled = false;
  late String salt;
  late String password;

  @override
  Widget build(BuildContext context) {
    bool isEmpty() {
      //Checks if any of the required fields are empty
      if ((_username.text.trim() != '') &&
          (_emailAddress.text.trim() != '') &&
          (_realName.text.trim() != '') &&
          (_phoneNumber.text.trim() != '') &&
          (_password.text.trim() != '')) {
        setState(() {
          isEnabled = true;
        });
      } else {
        setState(() {
          isEnabled = false;
        });
      }
      return true;
    }

    _username.addListener(isEmpty);
    _emailAddress.addListener(isEmpty);
    _realName.addListener(isEmpty);
    _phoneNumber.addListener(isEmpty);
    _password.addListener(isEmpty);

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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Add User",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff343434),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: TextField(
                  controller: _username,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                    hintText: "e.g john_tan",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: TextField(
                  controller: _emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email Address",
                    hintText: "e.g john_tan@hotmail.com",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: TextField(
                  controller: _realName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Real Name",
                    hintText: "e.g Johnathan Tan",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: TextField(
                  controller: _phoneNumber,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone Number",
                    hintText: "e.g 98761234",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: _buildAddButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String generateSalt() {
    Random random = Random.secure();

    String CreateCryptoRandomString([int length = 32]) {
      var values = List<int>.generate(length, (i) => random.nextInt(256));

      return base64Url.encode(values);
    }

    return CreateCryptoRandomString(32);
  }

  void createPassword() {
    salt = generateSalt();
    var saltedPassword = salt + _password.text;
    var bytes = utf8.encode(saltedPassword);
    var hashedPassword = sha256.convert(bytes);
    password = hashedPassword.toString();
  }

  String? validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  Widget _buildAddButton() {
    //Widget to build the add user button
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade700),
        onPressed: isEnabled
            ? () {
                createPassword();
                Navigator.pop(
                    context,
                    Users(
                        username: _username.text,
                        emailAddress: _emailAddress.text,
                        name: _realName.text,
                        phoneNumber: int.parse(_phoneNumber.text),
                        password: password,
                        salt: salt,
                        isAdmin: 0));
              }
            : null,
        child: const Text('Add User'));
  }
}
