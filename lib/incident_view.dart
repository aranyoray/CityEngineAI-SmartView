// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smart_view/userPages/home_page.dart';
import 'constants.dart' as constants;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smart_view/model/case.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class IncidentView extends StatefulWidget {
  final Case selectedCase;
  const IncidentView({super.key, required this.selectedCase});

  @override
  State<IncidentView> createState() => _IncidentViewState();
}

class _IncidentViewState extends State<IncidentView> {
  int incidentid = 0;
  late VoidCallback refreshFunc;
  final TextEditingController _officerNotes = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  late Case selectedCase;
  String incident_location = "";

  // TODO: ADD OWN API KEY
  static const googleApiKey = "ADDINAPIKEY";

  // update event description in database
  void _updateIncident() async {
    final response = await http.put(
      Uri.parse(constants.updateDescription + incidentid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'officer_notes': _officerNotes.text}),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Event Description Updated Successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // update case status to completed in database
  void _updateStatus() async {
    final response = await http.put(
      Uri.parse(constants.updateStatus + incidentid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'incident_status': "completed"}),
    );
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Case Closed Successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // get incident status based on incident id
  Future<String> _findStatus(int incidentId) async {
    final response = await http.get(
      Uri.parse(constants.findStatus + incidentId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      String caseStatus = jsonDecode(response.body)[0]['incident_status'];
      return caseStatus;
    } else {
      throw Exception('Failed to find status');
    }
  }

  // get incident location based on cctv location
  Future<String> _findLocation(int incidentid) async {
    final response = await http.get(
      Uri.parse(constants.findCCTVAddress + incidentid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final location = jsonDecode(response.body)['cctv_physical_address'];
      return location;
    } else {
      throw Exception('Failed to find location');
    }
  }

  // get incident coordinates based on cctv location
  Future<LatLng> _findCoordinates(int incidentid) async {
    final response = await http.get(
      Uri.parse(constants.findCCTVCoord + incidentid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final double latitude = jsonResponse['cctv_latitude'];
      final double longitude = jsonResponse['cctv_longitude'];

      return LatLng(latitude, longitude);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to find location: $error');
    }
  }

  // Latitude and longitude of camera that captured the incident and officer location
  LatLng incidentCoordinates = LatLng(0, 0);
  LatLng officerLocation = LatLng(0, 0);

  // Define the polyline coordinates list
  List<LatLng> polylineCoordinates = [];

  // Get the incident coordinates
  void getIncidentCoordinates(int incidentId) async {
    LatLng incident = await _findCoordinates(incidentId);
    setState(() {
      incidentCoordinates = incident;
    });
  }

  // Get the current location of the device
  Future<LatLng> getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Location service is not enabled, handle the error
        return Future.error('Location service is not enabled.');
      }
    }

    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        // Location permission not granted, handle the error
        return Future.error('Location permission not granted.');
      }
    }

    LocationData currentLocation = await location.getLocation();

    return LatLng(currentLocation.latitude!, currentLocation.longitude!);
  }

  // Get the polyline points and add the resulting polyline to the map
  void getPolylinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    // Get the polyline points between the incident location and officer location
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(incidentCoordinates.latitude, incidentCoordinates.longitude),
      PointLatLng(officerLocation.latitude, officerLocation.longitude),
    );

    // Clear existing polyline coordinates and add the new points
    polylineCoordinates.clear();
    for (var point in result.points) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }

    // Update the map
    // setState(() {});
  }

  @override
  void dispose() {
    _officerNotes.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedCase = widget.selectedCase;
    String? officerNotes = selectedCase.officerNotes;
    if (selectedCase.officerNotes == null) {
      _officerNotes.text = "";
    } else {
      _officerNotes.text = officerNotes!;
    }

    incidentid = selectedCase.incidentid!;
    getIncidentCoordinates(incidentid);

    // Wait for getCurrentLocation to complete and update officerLocation before calling getPolylinePoints and setState
    getCurrentLocation().then((value) {
      getPolylinePoints();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //Init the values
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
            color: constants.secondaryBlueColour,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Title text
            Center(
              child: Text(
                widget.selectedCase.incidenttype,
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff343434),
                ),
              ),
            ),

            // Date and time text
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30.0, top: 30.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.schedule,
                      size: 35.0,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date/Time of Incident',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff343434),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        DateFormat('dd-MM-yyyy, kk:mm:ss')
                            .format(widget.selectedCase.incidenttime),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xff343434),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Description text
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30.0, top: 10.0),
              child: Text(
                widget.selectedCase.incidentdescription,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xff343434),
                ),
              ),
            ),

            // Gallery title text
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30.0, top: 20.0),
              child: Text(
                'Incident Screenshots',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff343434),
                ),
              ),
            ),

            // Image
            const Padding(
              padding: EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 10.0, bottom: 20.0),
              child: Image(image: AssetImage('assets/images/fight.png')),
            ),

            // Google Maps
            FutureBuilder<LatLng>(
              future: getCurrentLocation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  officerLocation = snapshot.data!;
                  getPolylinePoints();
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 400,
                    child: GoogleMap(
                      gestureRecognizers: Set()
                        ..add(Factory<PanGestureRecognizer>(
                            () => PanGestureRecognizer())),
                      initialCameraPosition: CameraPosition(
                        target: officerLocation,
                        zoom: 14.5,
                      ),
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId("route"),
                          points: polylineCoordinates,
                          color: const Color(0xff00358f),
                          width: 6,
                          visible: true,
                          onTap: () {},
                        ),
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId('incident'),
                          position: incidentCoordinates,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueGreen),
                        ),
                        Marker(
                          markerId: MarkerId('officer'),
                          position: officerLocation,
                        ),
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.hexagonDots(
                          color: constants.textGrayColour, size: 50),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  );
                }
              },
            ),

            // Location details box
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
              margin:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              decoration: const BoxDecoration(
                color: Color(0xff00358f),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: FutureBuilder<String>(
                  future: _findLocation(incidentid),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      String location = snapshot.data!;
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                            left: 5.0, top: 5.0, bottom: 5.0),
                        decoration: const BoxDecoration(
                          color: Color(0xff00358f),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Location: $location",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          LoadingAnimationWidget.hexagonDots(
                              color: Colors.white, size: 50),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      );
                    }
                  }),
            ),

            // Event description text
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30.0, top: 10.0),
              child: Text(
                'Event Description',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff343434),
                ),
              ),
            ),

            // Event description textfield
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
              child: TextField(
                controller: _officerNotes,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: 'Enter Description',
                ),
                onChanged: (String value) {
                  selectedCase.officerNotes = value;
                },
              ),
            ),

            // Save button
            SizedBox(
              width: 100.0,
              child: ElevatedButton(
                onPressed: _updateIncident,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(constants.textGrayColour),
                ),
                child: const Text('Save'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
              child: FutureBuilder<String>(
                future: _findStatus(incidentid),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    final caseStatus = snapshot.data;

                    if (caseStatus == "completed") {
                      return Container(); // Return an empty container to hide the button
                    } else {
                      return ElevatedButton(
                        onPressed: _updateStatus,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff00358f)),
                        ),
                        child: const Text('Close Case'),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
