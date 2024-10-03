import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_view/adminPages/ArgsClass.dart';
import 'package:http/http.dart' as http;
import 'package:smart_view/constants.dart' as constants;
import 'dart:convert';

class ViewCCTV extends StatefulWidget {
  @override
  const ViewCCTV({super.key});

  @override
  _ViewCCTVState createState() => _ViewCCTVState();
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewCCTVState extends State<ViewCCTV> {
  final TextEditingController _cctvName = TextEditingController();
  final TextEditingController _rtspLinkAddress = TextEditingController();
  final TextEditingController _physicalAddress = TextEditingController();
  late int idcctv;
  late VoidCallback refreshFunc;
  bool isEnabled = false;

  //We are using a list to store this for now as we don't have a better way of storing it
  //Index mapping as follows
  // loiteringAnalytics = 0;
  // intrusionAnalytics = 1;
  // violenceAnalytics = 2;
  // abandoneObjectAnalytics = 3;
  // fireDetectionAnalytics = 4;
  List<bool> analyticsList = [false, false, false, false, false];

  @override
  void dispose() {
    _cctvName.dispose();
    _rtspLinkAddress.dispose();
    _physicalAddress.dispose();
    super.dispose();
    //Calls the refresh function from admin_page when this page is disposed of
    //to update the page
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
                Navigator.of(context).pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeletionConfirmation() async {
    //Dialog box that shows up when user clicks on delete
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm deletion?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to delete this camera?'),
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
    if ((_cctvName.text.isEmpty) ||
        (_physicalAddress.text.isEmpty) ||
        (_rtspLinkAddress.text.isEmpty)) {
      _showErrorDialog();
    } else {
      final response = await http.put(
        Uri.parse(constants.fetchSpecificCCTV + idcctv.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'cctv_name': _cctvName.text,
          'cctv_link_address': _rtspLinkAddress.text,
          'cctv_physical_address': _physicalAddress.text
        }),
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
      }
    }
  }

  void deleteEntry() async {
    final response = await http.delete(
      Uri.parse(constants.fetchSpecificCCTV + idcctv.toString()),
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
    final args = ModalRoute.of(context)!.settings.arguments as CCTVArgs;
    var cctv = args.cctv;
    refreshFunc = args.voidFunc;

    //Init the values
    idcctv = cctv.cctvId;
    String cctvName = cctv.cctvName;
    String cctvLinkAddr = cctv.cctvLinkAddress;
    String cctvPhysicalAddr = cctv.cctvPhysicalAddress;
    _cctvName.text = cctvName;
    _rtspLinkAddress.text = cctvLinkAddr;
    _physicalAddress.text = cctvPhysicalAddr;

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
          child: Column(
            children: [
              Center(
                child: Text(
                  "Viewing ${cctv.cctvName}",
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
                        controller: _cctvName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "CCTV Name",
                        ),
                        onChanged: (String value) {
                          cctvName = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: TextField(
                        controller: _rtspLinkAddress..text = cctvLinkAddr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "RTSP Link Address",
                        ),
                        onChanged: (String value) {
                          cctvLinkAddr = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: TextField(
                        controller: _physicalAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Physical Address",
                        ),
                        onChanged: (String value) {
                          cctvPhysicalAddr = value;
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(25),
                        child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                            const SizedBox(
                              width: 10,
                            ),
                            Text("Select Analytics to use",
                                style: GoogleFonts.poppins(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff343434))),
                            const SizedBox(
                              width: 10,
                            ),
                            _buildCheckbox("Loitering", 0),
                            _buildCheckbox("Intrusion", 1),
                            _buildCheckbox("Violence", 2),
                            _buildCheckbox("Abandoned Objects", 3),
                            _buildCheckbox("Fire Detection", 4),
                          ]),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: _buildAddButton(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildCheckbox(String analyticsName, int analyticsIndex) {
    //Widget to build labelled checkboxes
    return LabeledCheckbox(
        label: analyticsName,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        value: analyticsList[analyticsIndex],
        onChanged: ((value) {
          setState(() {
            analyticsList[analyticsIndex] = value;
          });
        }));
  }

  Widget _buildAddButton() {
    //Widget to build buttons for Updating and Deleting
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700),
                onPressed: checkIfEmptyAndUpdate,
                child: const Text('Update Camera'))),
        Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 179, 58, 58)),
                onPressed: _showDeletionConfirmation,
                child: const Text('Delete Camera')))
      ],
    );
  }
}
