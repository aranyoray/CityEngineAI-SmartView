import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_view/model/cctv.dart';

class AddCCTV extends StatefulWidget {
  @override
  _AddCCTVState createState() => _AddCCTVState();
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

class _AddCCTVState extends State<AddCCTV> {
  final TextEditingController _cctvName = TextEditingController();
  final TextEditingController _rtspLinkAddress = TextEditingController();
  final TextEditingController _physicalAddress = TextEditingController();

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
  Widget build(BuildContext context) {
    //Function to check if the CCTV name, address and ip address are filled
    bool isEmpty() {
      if ((_cctvName.text.trim() != '') &&
          (_rtspLinkAddress.text.trim() != '') &&
          (_physicalAddress.text.trim() != '')) {
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

    _cctvName.addListener(isEmpty);
    _rtspLinkAddress.addListener(isEmpty);
    _physicalAddress.addListener(isEmpty);

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
          child: Column(children: [
            Center(
              child: Text(
                "Add CCTV",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff343434),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: TextField(
                    controller: _cctvName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "CCTV Name",
                      hintText: "e.g Camera 1",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: TextField(
                    controller: _rtspLinkAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "RTSP Link Address",
                      hintText: "e.g rtsp://admin:********",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: TextField(
                    controller: _physicalAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Physical Location",
                      hintText: "e.g Main Street",
                    ),
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
                        //Calls function to build 5 checkboxes
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
          ]),
        ),
      ),
    );
  }

  //Reusable widget to build the checkboxes
  Widget _buildCheckbox(String analyticsName, int analyticsIndex) {
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

  //Widget to build the button to add CCTV
  Widget _buildAddButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade700),
        onPressed: isEnabled
            ? () {
                Navigator.pop(
                    context,
                    CCTV.withAnalytics(
                        0,
                        _cctvName.text,
                        _rtspLinkAddress.text,
                        _physicalAddress.text,
                        0.0, //Placeholder
                        0.0, //Placeholder
                        analyticsList[0],
                        analyticsList[1],
                        analyticsList[2],
                        analyticsList[3],
                        analyticsList[
                            4])); //Magic number 0 as it is autoincrement
              }
            : null,
        child: const Text('Add Camera'));
  }
}
