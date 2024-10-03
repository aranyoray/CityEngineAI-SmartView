import 'dart:ui';

const Color HIGH_PRIORITY = Color.fromRGBO(227, 113, 110, 1);
const Color MEDIUM_PRIORITY = Color.fromRGBO(246, 213, 92, 1);
const Color LOW_PRIORITY = Color.fromRGBO(105, 225, 85, 1);
const secondaryBlueColour = Color.fromRGBO(0, 53, 143, 1.0);
const textGrayColour = Color.fromRGBO(61, 61, 61, 1.0);
const Color mainBackgroundColour = Color.fromRGBO(240, 240, 240, 1.0);
const Color categoryButtonBackgroundColour = Color.fromRGBO(217, 217, 217, 1.0);
const Color badgeColour = Color.fromRGBO(227, 113, 110, 1);
const Color filterChipGrey = Color.fromARGB(255, 168, 168, 168);
const int sortByPriorityLowtoHigh = 2;
const int sortByPriorityHightoLow = 1;
const int sortByEarliesttoLatest = 3;
const int sortByLatesttoEarliest = 4;
const String apiString = "http://10.0.2.2:3000";
const String ongoingCases = "WHERE incident_status='ongoing';";
const String completedCases = "WHERE incident_status='completed';";
const String fetchCasesAssigned = "$apiString/incidents/";
const String endpointUsers = "$apiString/allusers";
const String fetchSpecificUser = "$apiString/users/";
const String endpointCCTVs = "$apiString/cctv";
const String fetchSpecificCCTV = "$apiString/cctv/";
const String fetchPriority = "$apiString/incidents/priority/";
const String updateStatus = "$apiString/incidents/status/";
const String findCCTVAddress = "$apiString/cctv/incident/";
const String findCCTVCoord = "$apiString/cctv/location/";
const String findStatus = "$apiString/incidents/getStatus/";
const String updateDescription = "$apiString/incidents/description/";

// TODO Implement this library.