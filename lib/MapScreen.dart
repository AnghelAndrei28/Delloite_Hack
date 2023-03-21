import 'dart:convert';

import 'package:digi_hack/CustomMark.dart';
import 'package:digi_hack/ReportScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget{
  static const routName = "/map";

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController; //contrller for Google map
  final Set<CustomMark> markers = new Set(); //markers for google map
  late LatLng currentLocation = const LatLng(44.483071, 26.111524);
  late bool report;

  @override
  void initState() {
    super.initState();
    _initialise();
  }

  _initialise()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Position initCoordinates = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    sharedPreferences.setDouble('oldLatitude', initCoordinates.latitude);
    sharedPreferences.setDouble('oldLongitude', initCoordinates.longitude);
  }



  _newEntry() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    currentLocation = new LatLng(sharedPreferences.getDouble('oldLatitude') ?? 0, sharedPreferences.getDouble('oldLongitude') ?? 0);
  }

  Future<http.Response> _fetchData() async{
    final response = await http.get(Uri.parse(
        "https://digi-hack-default-rtdb.firebaseio.com/reports.json?"));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print("A ajuns la adaugare");
    if (extractedData != null) {
      print("A gasit date");
        print("Extracted =" + extractedData.toString());
        extractedData.forEach((orderId, orderData){markers.add(CustomMark(orderId, MarkerId(orderId), orderData['userId'], orderData['type'], new LatLng(orderData['lat'], orderData['lon']), orderData['description'], context));
        });
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    report = ModalRoute.of(context)!.settings.arguments as bool;
    return  Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: _setCurrentLocation, icon: Icon(Icons.location_history),),
          ],
          title: Text("Multiple Markers in Google Map"),
        ),
        body:  FutureBuilder(
          future: _fetchData(),
          builder: (context, response) {
            if(response.data == null) {

              return const Center(child: CircularProgressIndicator());
            }
            return GoogleMap( //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true, //enable Zoom in, out on map
              initialCameraPosition: CameraPosition( //innital position in map
                target: currentLocation, //initial position
                zoom: 15.0, //initial zoom level
              ),
              markers: getmarkers(), //markers to show on map
              mapType: MapType.normal, //map type
              onMapCreated: (controller) { //method called when map is created
                setState(() {
                  mapController = controller;
                });
              },
              onTap: _handleTap,
            );
          }
        )
    );
  }

  _setCurrentLocation() async {
    _newEntry();
    mapController.animateCamera(CameraUpdate.newCameraPosition(const CameraPosition(target: LatLng(44.483071, 26.111524), zoom: 18)));
  }

  _handleTap(LatLng point) async{
    var result = await  Navigator.pushNamed(context, ReportScreen.routName, arguments: point);
    setState(() {
      markers.add(CustomMark(
        DateTime.now().toString(),
          MarkerId(point.toString()),
          "userID",
          report,
          point,
          "$result",
        context
      ));
    });
  }

  Set<Marker> getmarkers() { //markers to place on map

    if(report)
    return [...markers].where((element) => element.lost).toSet();

    else {
      return [...markers].where((element) => !element.lost).toSet();
    }
  }
}