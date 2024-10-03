import 'package:flutter/material.dart';
import 'package:smart_view/adminPages/ArgsClass.dart';
import 'package:smart_view/adminPages/view_user.dart';
import 'package:smart_view/constants.dart' as constants;
import 'package:smart_view/model/users.dart';

class UserWidget extends StatelessWidget {
  final Users user;
  final VoidCallback refreshFunc;

  const UserWidget({super.key, required this.user, required this.refreshFunc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ViewUser(),
                  settings:
                      RouteSettings(arguments: UserArgs(user, refreshFunc))));
        },
        child: Align(
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            width: 380,
            height: 130,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Card(
              elevation: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(user.username,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(user.phoneNumber.toString()),
                    textColor: constants.textGrayColour,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                            onPressed: () {/* ... */},
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    constants.categoryButtonBackgroundColour)),
                            child: Text(user.emailAddress,
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
