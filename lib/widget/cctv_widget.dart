import 'package:flutter/material.dart';
import 'package:smart_view/adminPages/ArgsClass.dart';
import 'package:smart_view/adminPages/view_cctv.dart';
import 'package:smart_view/constants.dart' as constants;
import 'package:smart_view/model/cctv.dart';

class CCTVWidget extends StatelessWidget {
  final CCTV cctv;
  final VoidCallback refreshPage;
  const CCTVWidget({super.key, required this.cctv, required this.refreshPage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewCCTV(),
                  settings:
                      RouteSettings(arguments: CCTVArgs(cctv, refreshPage))));
        },
        child: Align(
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            height: 130,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Card(
              elevation: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(cctv.cctvName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(cctv.cctvLinkAddress),
                    textColor: constants.textGrayColour,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    constants.categoryButtonBackgroundColour)),
                            child: Text(cctv.cctvPhysicalAddress,
                                style: const TextStyle(
                                    color: constants.textGrayColour))),
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
