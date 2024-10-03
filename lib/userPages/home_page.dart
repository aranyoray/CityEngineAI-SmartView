// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:convert';
import 'package:flutter/material.dart' hide Badge;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_view/model/case.dart';
import 'package:smart_view/model/filter_chip.dart';
import 'package:smart_view/settingsPages/settings_page.dart';
import 'package:smart_view/userPages/search_cases.dart';
import 'package:smart_view/widget/case_widget.dart';
import 'package:smart_view/constants.dart' as constants;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smart_view/widget/filtercases_widget.dart';
import 'package:smart_view/widget/sortcases_widget.dart';
import 'package:badges/badges.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currName = "";
  int selectedRadioTile = 0;
  int refreshSelectedIndex = 0;
  bool showBadgeSort = false;
  bool showBadgeFilter = false;
  bool noCases = false;
  bool finishedLoading = false;
  bool errorLoading = false;
  bool isCase = true;
  List<String> priorityLowtoHighOrder = ['low', 'medium', 'high'];
  List<String> priorityHightoLowOrder = ['high', 'medium', 'low'];
  List<Case> cases = [];
  List<Case> searchCases = [];
  List<Case> filteredCases = [];
  List<FilterChipModel> filterList = [
    FilterChipModel("Low", true),
    FilterChipModel("Medium", true),
    FilterChipModel("High", true)
  ];
  late FToast fToast;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController _refreshControllerError =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    switch (refreshSelectedIndex) {
      case 0:
        {
          fetchCases("");
        }
        break;
      case 1:
        {
          fetchCases("ongoing");
        }
        break;
      case 2:
        {
          fetchCases("completed");
        }
        break;
    }
    _refreshControllerError.refreshCompleted();
    _refreshController.refreshCompleted();
    _showToast();
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color.fromARGB(150, 20, 20, 20),
      ),
      child: Text("Refresh completed.", style: TextStyle(color: Colors.white)),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  Future<Null> getSharedPrefName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _name = pref.getString("currName");
    setState(() {
      currName = _name.toString();
    });
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    fetchCases("");
    setSelectedRadioTile(constants.sortByPriorityHightoLow);
    getSharedPrefName();
    fToast = FToast();
    fToast.init(context);
  }

  //Sort the list of cases to be displayed from low priority to high priority
  //where all the cases are sorted based on the priority level they were
  //assigned
  void sortCasesPriorityLowtoHigh() {
    cases.sort(((a, b) {
      return priorityLowtoHighOrder.indexOf(a.prioritylevel.toLowerCase()) -
          priorityLowtoHighOrder.indexOf(b.prioritylevel.toLowerCase());
    }));
  }

  //Sort the list of cases to be displayed from high priority to low where all
  //the cases are sorted based on the priorty level that they were assigned
  void sortCasesPriorityHightoLow() {
    cases.sort(((a, b) {
      return priorityLowtoHighOrder.indexOf(b.prioritylevel.toLowerCase()) -
          priorityLowtoHighOrder.indexOf(a.prioritylevel.toLowerCase());
    }));
  }

  //Sort the list of cases to be displayed from earliest to latest where all
  //the cases are sorted by the incidient times
  void sortCasesEarliesttoLatest() {
    cases.sort(((a, b) {
      var adate = a.incidenttime;
      var bdate = b.incidenttime;
      return adate.compareTo(bdate);
    }));
  }

  //Sort the list of cases to be displayed from latest to earliest where all
  //the cases are sorted by the incident times
  void sortCasesLatesttoEarliest() {
    cases.sort(((a, b) {
      var adate = a.incidenttime;
      var bdate = b.incidenttime;
      return bdate.compareTo(adate);
    }));
  }

  void setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      if (selectedRadioTile == constants.sortByPriorityLowtoHigh) {
        sortCasesPriorityLowtoHigh();
        showBadgeSort =
            true; // Show badge on sort icon to indicate sort applied
      }
      if (selectedRadioTile == constants.sortByPriorityHightoLow) {
        sortCasesPriorityHightoLow();
        showBadgeSort =
            false; // Default sorting thus wont show badge on sort icon
      }

      if (selectedRadioTile == constants.sortByEarliesttoLatest) {
        sortCasesEarliesttoLatest();
        showBadgeSort =
            true; // Show badge on sort icon to indicate sort applied
      }
      if (selectedRadioTile == constants.sortByLatesttoEarliest) {
        sortCasesLatesttoEarliest();
        showBadgeSort =
            true; // Show badge on sort icon to indicate sort applied
      }
    });
  }

  // Set filtering of cases
  Future<void> setFilterCase() async {
    filteredCases.clear();
    for (var level in filterList) {
      if (level.isSelected == true) {
        filteredCases.addAll(await fetchPriority(level.label));
      }
    }
    // If all filters are selected, hide the filter badge
    if (filterList[0].isSelected &&
        filterList[1].isSelected &&
        filterList[2].isSelected) {
      setState(() {
        cases = filteredCases;
        showBadgeFilter = false;
      });
    } else {
      setState(() {
        cases = filteredCases;
        showBadgeFilter = true;
      });
    }
  }

//  Fetching incidents/cases to be displayed on homescreen
  Future<List<Case>> fetchCases(String tab) async {
    try {
      final response = await http
          .get(Uri.parse(constants.fetchCasesAssigned + tab))
          .timeout(const Duration(seconds: 5));

      switch (response.statusCode) {
        case 200:
          List jsonResponse = json.decode(response.body); // decode into a list
          cases = jsonResponse
              .map((data) => Case.fromJson(data))
              .toList(); // convert the json to a Case

          setState(() {
            setSelectedRadioTile(selectedRadioTile);
            finishedLoading = true;
            isCase = true;
            errorLoading = false;
          });

          return cases;

        default:
          return cases;
      }
    } catch (e) {
      setState(() {
        finishedLoading = true;
        errorLoading = true;
      });

      throw Exception('Failed to load incidents');
    }
  }

  Future<List<Case>> fetchPriority(String tab) async {
    try {
      final response = await http
          .get(Uri.parse(constants.fetchPriority + tab))
          .timeout(const Duration(seconds: 5));

      switch (response.statusCode) {
        case 200:
          List jsonResponse = json.decode(response.body); // decode into a list
          cases = jsonResponse
              .map((data) => Case.fromJson(data))
              .toList(); // convert the json to a Case

          setState(() {
            setSelectedRadioTile(selectedRadioTile);
            finishedLoading = true;
            isCase = true;
            errorLoading = false;
          });

          return cases;

        default:
          return cases;
      }
    } catch (e) {
      setState(() {
        finishedLoading = true;
        errorLoading = true;
      });

      throw Exception('Failed to load incidents');
    }
  }

  Future<List<String>> _getRecentSearchesLike(String query) async {
    final pref = await SharedPreferences.getInstance();
    final allSearches = pref.getStringList("recentSearches");
    try {
      return allSearches!.where((search) => search.startsWith(query)).toList();
    } catch (e) {
      return [];
    }
  }


  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          backgroundColor: constants.mainBackgroundColour,
          title: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back,",
                  style: TextStyle(
                      color: constants.textGrayColour, fontSize: 12.0),
                ),
                Text(
                  currName,
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
              icon: Icon(Icons.settings),
              color: constants.secondaryBlueColour,
              onPressed: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()))
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              color: constants.secondaryBlueColour,
              onPressed: () async => {
                showSearch(
                    context: context,
                    delegate: MySearchDelegate(
                        cases: await fetchCases(""),
                        onSearchChanged: _getRecentSearchesLike))
              },
            )
          ],
          bottom: TabBar(
            labelColor: constants.textGrayColour,
            indicatorColor: constants.secondaryBlueColour,
            indicatorWeight: 5,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: GoogleFonts.poppins().fontFamily),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: GoogleFonts.poppins().fontFamily),
            tabs: [
              Tab(text: "All Cases"),
              Tab(text: "Ongoing"),
              Tab(text: "Completed"),
            ],
            onTap: (selectedIndex) {
              switch (selectedIndex) {
                case 0:
                  {
                    refreshSelectedIndex = selectedIndex;
                    fetchCases("");
                  }
                  break;
                case 1:
                  {
                    refreshSelectedIndex = selectedIndex;
                    fetchCases("ongoing");
                  }
                  break;
                case 2:
                  {
                    refreshSelectedIndex = selectedIndex;
                    fetchCases("completed");
                  }
                  break;
              }
            },
          ),
        ),
        body: !finishedLoading
            ? Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      LoadingAnimationWidget.hexagonDots(
                          color: constants.textGrayColour, size: 80),
                      SizedBox(height: 10.0),
                      Text("Loading...")
                    ],
                  ),
                ),
              )
            : errorLoading
                ? Scaffold(
                    body: SmartRefresher(
                        enablePullDown: true,
                        controller: _refreshControllerError,
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error,
                                size: 100,
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 10)),
                              Text(
                                "Error retrieving incidents, pull up to refresh!",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 5),
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 2.0,
                                    color: constants
                                        .categoryButtonBackgroundColour),
                              )),
                              child: TextButton.icon(
                                  onPressed: (() {
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        context: context,
                                        builder: (BuildContext build) {
                                          return SortCasesWidget(
                                              selectedRadioTile:
                                                  selectedRadioTile,
                                              setSelectedRadioTile:
                                                  setSelectedRadioTile);
                                        });
                                  }),
                                  icon: Badge(
                                    elevation: 0,
                                    showBadge: showBadgeSort,
                                    badgeColor: constants.badgeColour,
                                    position:
                                        BadgePosition.topEnd(end: -5, top: -5),
                                    badgeContent: SizedBox(
                                      width: 1,
                                      height: 1,
                                    ),
                                    child: Icon(
                                      Icons.sort,
                                      size: 28,
                                      color: constants.textGrayColour,
                                    ),
                                  ),
                                  label: Text("Sort",
                                      style: TextStyle(
                                          color: constants.textGrayColour,
                                          fontWeight: FontWeight.bold)))),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                                border: Border(
                              left: BorderSide(
                                  width: 2.0,
                                  color:
                                      constants.categoryButtonBackgroundColour),
                              bottom: BorderSide(
                                  width: 2.0,
                                  color:
                                      constants.categoryButtonBackgroundColour),
                            )),
                            child: TextButton.icon(
                                onPressed: () {
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      context: context,
                                      builder: (BuildContext build) {
                                        return FilterCasesWidget(
                                            filterList: filterList,
                                            setFilterCase: setFilterCase);
                                      });
                                },
                                icon: Badge(
                                  elevation: 0,
                                  showBadge: showBadgeFilter,
                                  badgeColor: constants.badgeColour,
                                  position:
                                      BadgePosition.topEnd(end: -5, top: -5),
                                  badgeContent: SizedBox(
                                    width: 1,
                                    height: 1,
                                  ),
                                  child: Icon(Icons.filter_alt,
                                      size: 28,
                                      color: constants.textGrayColour),
                                ),
                                label: Text("Filter",
                                    style: TextStyle(
                                        color: constants.textGrayColour,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SmartRefresher(
                          enablePullDown: true,
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                          child: ListView.builder(
                            itemBuilder: ((context, index) {
                              return CaseWidget(
                                c: cases[index],
                              );
                            }),
                            itemCount: cases.length,
                          ),
                        ),
                      ),
                    ],
                  ),
      ));
}
