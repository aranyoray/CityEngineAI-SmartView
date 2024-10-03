// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_view/constants.dart' as constants;

class SortCasesWidget extends StatefulWidget {
  int selectedRadioTile = 0;
  final Function setSelectedRadioTile;
  SortCasesWidget(
      {super.key,
      required this.selectedRadioTile,
      required this.setSelectedRadioTile});

  @override
  State<SortCasesWidget> createState() => _SortCasesWidgetState();
}

class _SortCasesWidgetState extends State<SortCasesWidget> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          children: [
            SizedBox(
              height: 50.0,
              child: Center(
                  child: Text(
                "Sort By",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
            ),
            Positioned(
                left: 0.0,
                top: 0.0,
                child: IconButton(
                    icon: Icon(Icons.arrow_back), // Your desired icon
                    onPressed: () {
                      Navigator.of(context).pop();
                    }))
          ],
        ),
        RadioListTile(
          value: 1,
          groupValue: widget.selectedRadioTile,
          title: Text("Priority Level High to Low"),
          onChanged: (val) {
            widget.setSelectedRadioTile(val!);
            Navigator.pop(context);
          },
          activeColor: constants.secondaryBlueColour,
        ),
        RadioListTile(
          value: 2,
          groupValue: widget.selectedRadioTile,
          title: Text("Priority Level Low to High"),
          onChanged: (val) {
            widget.setSelectedRadioTile(val!);
            Navigator.pop(context);
          },
          activeColor: constants.secondaryBlueColour,
        ),
        RadioListTile(
          value: 3,
          groupValue: widget.selectedRadioTile,
          title: Text("Case Earliest to Latest"),
          onChanged: (val) {
            widget.setSelectedRadioTile(val!);
            Navigator.pop(context);
          },
          activeColor: constants.secondaryBlueColour,
        ),
        RadioListTile(
          value: 4,
          groupValue: widget.selectedRadioTile,
          title: Text("Case Latest to Earliest"),
          onChanged: (val) {
            widget.setSelectedRadioTile(val!);
            Navigator.pop(context);
          },
          activeColor: constants.secondaryBlueColour,
        ),
      ],
    );
  }
}
