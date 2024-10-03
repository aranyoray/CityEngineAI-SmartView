// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_view/model/filter_chip.dart';
import 'package:smart_view/constants.dart' as constants;

class FilterCasesWidget extends StatefulWidget {
  List<FilterChipModel> filterList = [];
  final Function setFilterCase;

  FilterCasesWidget(
      {super.key, required this.filterList, required this.setFilterCase});

  @override
  State<FilterCasesWidget> createState() => _FilterCasesWidgetState();
}

class _FilterCasesWidgetState extends State<FilterCasesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Stack(
        children: [
          SizedBox(
            height: 50.0,
            child: Center(
                child: Text(
              "Filter By",
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
      Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child:
              Wrap(runSpacing: 3.0, spacing: 5.0, children: filterChipsList()),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                for (int i = 0; i < widget.filterList.length; i++) {
                  widget.filterList[i].isSelected = true;
                }
              });
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff00358f)),
            ),
            child: const Text('Reset Filters'),
          ),
          SizedBox(
            width: 30,
          ),
          ElevatedButton(
            onPressed: () {
              widget.setFilterCase();
              Navigator.pop(context);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff00358f)),
            ),
            child: const Text('Apply Filters'),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      )
    ]);
  }

  List<Widget> filterChipsList() {
    List<Widget> chips = [];
    for (int i = 0; i < widget.filterList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          label: Text(widget.filterList[i].label),
          labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
          backgroundColor: Color.fromARGB(255, 214, 214, 214),
          selected: widget.filterList[i].isSelected,
          onSelected: (bool value) {
            setState(() {
              widget.filterList[i].isSelected = value;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
