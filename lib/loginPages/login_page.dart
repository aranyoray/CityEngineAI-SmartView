// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_view/adminPages/admin_panel.dart';
import 'package:smart_view/model/users.dart';
import 'package:smart_view/userPages/home_page.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import './forgot_password_page.dart';
import 'package:http/http.dart' as http;
import 'package:smart_view/constants.dart' as constants;

late FToast fToast;
late String currName;
late String currUser;
late String currRole;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  late Users user;
  bool successgetUsers = false;
  bool showLoginLoading = false;

  void userLogin(String username, String password) async {
    getUsers(username.replaceAll(" ", ""));
    await Future.delayed(Duration(milliseconds: 500));

    if (successgetUsers) {
      try {
        if (user.name == "") {
          _showToast("Incorrect Login Credentials. Please try again.");
          setState(() {
            showLoginLoading = false;
          });
        } else if (hashPassword(password, user.password, user.salt)) {
          if (user.isAdmin == 0) {
            final pref = await SharedPreferences.getInstance();
            await pref.setString('currUser', user.username);
            await pref.setString('currName', user.name);
            await pref.setString('currRole', "user");
            await pref.setBool('isLogin', true);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          } else if (user.isAdmin == 1) {
            final pref = await SharedPreferences.getInstance();
            await pref.setString('currUser', user.username);
            await pref.setString('currName', user.name);
            await pref.setString('currRole', "admin");
            await pref.setBool('isLogin', true);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AdminPage(title: username)));
          }
        }
      } catch (e) {
        throw Exception("User not defined");
      }
    }
  }

  Future<void> getSharedPrefUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    currName = pref.getString("currName").toString();
    currUser = pref.getString("currUser").toString();
    currRole = pref.getString("currRole").toString();
    setState(() {
      if (currRole == "user") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      } else if (currRole == "admin") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => AdminPage(title: currUser)));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefUser();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color.fromARGB(150, 20, 20, 20),
      ),
      child: Text(message, style: TextStyle(color: Colors.white)),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  bool hashPassword(String inputPassword, String savedPassword, String salt) {
    var saltedPassword = salt + inputPassword;
    var bytes = utf8.encode(saltedPassword);
    var hashedPassword = sha256.convert(bytes);
    String finalPassword = hashedPassword.toString();
    if (finalPassword == savedPassword) {
      return true;
    } else {
      _showToast("Incorrect Login Credentials. Please try again.");
      setState(() {
        showLoginLoading = false;
      });
      return false;
    }
  }

  void getUsers(String username) async {
    try {
      final response = await http
          .get(Uri.parse(constants.fetchSpecificUser + username))
          .timeout(const Duration(seconds: 5));
      switch (response.statusCode) {
        case 200:
          user = Users.fromJson(json.decode(response.body));
          successgetUsers = true;
          break;
        case 404:
          _showToast("Incorrect Login Credentials. Please try again.");
          setState(() {
            showLoginLoading = false;
          });
          break;
        default:
      }
    } catch (e) {
      _showToast("Network error, please try again!");
      setState(() {
        showLoginLoading = false;
      });
      throw Exception("Failed to get users");
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

                //logo
                Image(image: AssetImage('assets/images/security.png')),
                SizedBox(height: 50),

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
                //         controller: _username,
                //         keyboardType: TextInputType.emailAddress,
                //         enableSuggestions: false,
                //         autocorrect: false,
                //         decoration: InputDecoration(
                //           border: InputBorder.none,
                //           prefixIcon: Icon(
                //             Icons.person,
                //             color: Colors.grey,
                //           ),
                //           hintText: 'Username',
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _username,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Username",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        )),
                  ),
                ),

                SizedBox(height: 15),

                //password textfield
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
                //         controller: _password,
                //         obscureText: true,
                //         enableSuggestions: false,
                //         autocorrect: false,
                //         decoration: InputDecoration(
                //           border: InputBorder.none,
                //           prefixIcon: Icon(
                //             Icons.lock,
                //             color: Colors.grey,
                //           ),
                //           hintText: 'Password',
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        )),
                  ),
                ),
                SizedBox(height: 10),

                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child:
                        //tap on forgot password to navigate to the page
                        GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xFF00358F),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                //sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          showLoginLoading = true;
                        });

                        userLogin(_username.text, _password.text);
                      },
                      color: Color(0xFF00358F),
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: showLoginLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 10),
                                LoadingAnimationWidget.hexagonDots(
                                    color: Colors.white, size: 20),
                              ],
                            )
                          : Text(
                              'Sign In',
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
