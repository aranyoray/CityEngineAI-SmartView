// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_view/model/case.dart';
import 'package:smart_view/incident_view.dart';
import 'package:smart_view/constants.dart' as constants;
import 'package:intl/intl.dart';

import '../incident_args.dart';

class CaseWidget extends StatelessWidget {
  final Case c;

  CaseWidget({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IncidentView(selectedCase: c),
            ),
          );
        },
        child: Align(
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            //width: 380,
            height: 130,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Card(
              elevation: 3,
              shape: Border(
                left: c.prioritylevel.toLowerCase() == "low"
                    ? BorderSide(color: constants.LOW_PRIORITY, width: 10)
                    : c.prioritylevel.toLowerCase() == "medium"
                        ? BorderSide(
                            color: constants.MEDIUM_PRIORITY, width: 10)
                        : c.prioritylevel.toLowerCase() == "high"
                            ? BorderSide(
                                color: constants.HIGH_PRIORITY, width: 10)
                            : BorderSide(
                                color: constants.LOW_PRIORITY, width: 10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text("CAM ${c.camid}",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(c.incidentdescription),
                    textColor: constants.textGrayColour,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 3),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy, kk:mm:ss')
                                  .format(c.incidenttime),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {/* ... */},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  constants.categoryButtonBackgroundColour)),
                          child: Text(c.incidenttype,
                              style:
                                  TextStyle(color: constants.textGrayColour)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
