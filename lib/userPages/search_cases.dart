// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:smart_view/constants.dart' as constants;
import 'package:smart_view/model/case.dart';
import 'package:smart_view/widget/case_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef OnSearchChanged = Future<List<String>> Function(String);

class MySearchDelegate extends SearchDelegate {
  List<Case> cases = [];
  List<Case> searchResults = [];
  List<String> searchHistory = [];

  final OnSearchChanged onSearchChanged;

  MySearchDelegate({required this.cases, required this.onSearchChanged});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: (() {
            query = '';
            showSuggestions(context);
          }),
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (() {
          close(context, '');
        }),
        icon: Icon(
          Icons.arrow_back_ios,
          color: constants.secondaryBlueColour,
        ));
  }

  Future<void> _saveToRecentSearches(String searchText) async {
    if (searchText == '') return; //Should not be null
    final pref = await SharedPreferences.getInstance();
    //Use `Set` to avoid duplication of recentSearches
    Set<String> allSearches =
        pref.getStringList("recentSearches")?.toSet() ?? {};

    //Place it at first in the set
    allSearches = {searchText, ...allSearches};
    pref.setStringList("recentSearches", allSearches.toList());
  }

  Future<void> _removeAndUpdateSearchHistory(List<String> searchHistory) async {
    final pref = await SharedPreferences.getInstance();
    pref.setStringList("recentSearches", searchHistory);
  }

  void refreshPage() {}

  @override
  Widget buildResults(BuildContext context) {
    searchResults = cases.where(((element) {
      return element.incidentdescription
          .toLowerCase()
          .contains(query.toLowerCase());
    })).toList();

    _saveToRecentSearches(query);
    return searchResults.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 100,
                ),
                Padding(padding: EdgeInsets.only(bottom: 10)),
                Text(
                  "No results found for '$query'",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Text(
                  "${searchResults.length} Result(s) for '$query'",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return CaseWidget(c: searchResults[index]);
                  }),
                  itemCount: searchResults.length,
                ),
              ),
            ],
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return FutureBuilder<List<String>>(
          future: onSearchChanged != null ? onSearchChanged(query) : null,
          builder: (context, snapshot) {
            if (snapshot.hasData) searchHistory = snapshot.data!;
            return searchHistory.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 20, right: 15, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Searches",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              child: Text(
                                "Clear All",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: constants.secondaryBlueColour),
                              ),
                              onTap: () {
                                setState(
                                  () {
                                    searchHistory.clear();
                                    _removeAndUpdateSearchHistory(
                                        searchHistory);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: searchHistory.length,
                            itemBuilder: ((context, index) {
                              final suggestion = searchHistory[index];
                              return ListTile(
                                leading: Icon(
                                  Icons.history,
                                  color: constants.secondaryBlueColour,
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      searchHistory.removeAt(index);
                                      _removeAndUpdateSearchHistory(
                                          searchHistory);
                                    });
                                  },
                                ),
                                title: Text(suggestion),
                                onTap: (() {
                                  if (query.isEmpty) {
                                    query = suggestion;
                                    showResults(context);
                                  }
                                }),
                              );
                            })),
                      ),
                    ],
                  )
                : Row();
          });
    });
  }
}
