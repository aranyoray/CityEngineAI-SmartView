import 'package:flutter/material.dart';
import 'package:smart_view/adminPages/add_user.dart';
import 'package:smart_view/model/users.dart';
import 'package:smart_view/widget/cctv_widget.dart';
import 'package:smart_view/widget/user_widget.dart';
import 'package:smart_view/settingsPages/settings_page.dart';
import 'package:smart_view/adminPages/add_cctv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smart_view/model/cctv.dart';
import 'package:http/http.dart' as http;
import 'package:smart_view/constants.dart' as constants;
import 'dart:convert';

var currName = "Admin East";

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const AdminPage(title: 'Admin Panel'),
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key, required this.title});

  final String title;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  bool isCCTV = true;
  List<CCTV> cctvs = [];
  List<Users> users = [];
  bool finishedLoading = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    getCCTV();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void getCCTV() async {
    setState(() {
      finishedLoading = false;
    });
    if (users.isNotEmpty) {
      cctvs.clear();
    }
    final response = await http.get(Uri.parse(constants.endpointCCTVs));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      cctvs = jsonResponse.map((e) => CCTV.fromJson(e)).toList();
      setState(() {
        finishedLoading = true;
      });
    } else {
      throw Exception("Failed to get CCTVs");
    }
  }

  void getUsers() async {
    setState(() {
      finishedLoading = false;
    });
    if (users.isNotEmpty) {
      users.clear();
    }
    final response = await http.get(Uri.parse(constants.endpointUsers));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      users = jsonResponse.map((e) => Users.fromJson(e)).toList();
      setState(() {
        finishedLoading = true;
      });
    } else {
      throw Exception("Failed to get users");
    }
  }

  Future<void> _openAddCCTVAndAddNewCCTV(BuildContext context) async {
    //Function opens the add CCTV page and awaits for a response from it before adding it to the CCTV table
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCCTV()),
    );
    if (!mounted) return;

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('CCTV added successfully'),
        duration: Duration(seconds: 1),
      ));
      finishedLoading = false;
      final response = await http.post(Uri.parse(constants.endpointCCTVs),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "cctv_name": result.cctvName,
            "cctv_link_address": result.cctvLinkAddress,
            "cctv_physical_address": result.cctvPhysicalAddress,
            "cctv_latitude": result.cctvLatitude,
            "cctv_longitude": result.cctvLongitude
          }));
      if (response.statusCode == 200) {
        setState(() {
          cctvs.clear(); //clears users list
          getCCTV(); //retrieve from db AGAIN
          finishedLoading = true;
        }); //force refresh
      }
    }
  }

  Future<void> _openAddUserAndAddNewUser(BuildContext context) async {
    //Function opens the add User page and awaits for a response from it before adding it to the Users table
    //TODO: Replace with POST equivalent from RESTful API
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddUser()),
    );
    if (!mounted) return;

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('User added successfully'),
        duration: Duration(seconds: 1),
      ));
      finishedLoading = false;
      final response = await http.post(Uri.parse(constants.fetchSpecificUser),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "username": result.username,
            "email_address": result.emailAddress,
            "name": result.name,
            "phone_number": result.phoneNumber,
            "password":
                result.password, //Change this to use password hashing feature
            "salt": result.salt,
            'is_admin': result.isAdmin
          }));
      if (response.statusCode == 200) {
        setState(() {
          users.clear(); //clears users list
          getUsers(); //retrieve from db AGAIN
          finishedLoading = true;
        }); //force refresh
      }
    }
  }

  void refreshPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          cctvs.clear(); //clears cctv list
          users.clear();
          getCCTV(); //retrieve from db AGAIN
          getUsers();
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (!finishedLoading) {
      return Scaffold(
          body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Column(
            children: [
              LoadingAnimationWidget.hexagonDots(
                  color: constants.textGrayColour, size: 80),
              const SizedBox(height: 10.0),
              const Text("Loading...")
            ],
          ),
        ),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color.fromRGBO(248, 248, 248, 1.0),
        title: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Welcome back,",
                style:
                    TextStyle(color: constants.textGrayColour, fontSize: 12.0),
              ),
              Text(
                "Admin",
                style: TextStyle(
                    color: constants.textGrayColour,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        centerTitle: false,
        leadingWidth: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: constants.secondaryBlueColour,
            onPressed: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SettingsPage()))
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: constants.textGrayColour,
          indicatorColor: constants.secondaryBlueColour,
          indicatorWeight: 5,
          indicatorPadding: const EdgeInsets.all(5),
          tabs: const [
            Tab(text: "CCTVs"),
            Tab(text: "User Management"),
          ],
          onTap: (selectedIndex) {
            switch (selectedIndex) {
              case 0:
                {
                  getCCTV();
                  isCCTV = true;
                }
                break;
              case 1:
                {
                  getUsers();
                  isCCTV = false;
                }
                break;
            }
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: isCCTV == true ? cctvs.length : users.length,
            itemBuilder: (BuildContext context, int index) {
              if (isCCTV) {
                return CCTVWidget(cctv: cctvs[index], refreshPage: refreshPage);
              } else {
                return UserWidget(user: users[index], refreshFunc: refreshPage);
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isCCTV
            ? () {
                _openAddCCTVAndAddNewCCTV(context);
              }
            : () {
                _openAddUserAndAddNewUser(context);
              },
        tooltip: 'Add new CCTV',
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.grey.shade100,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
