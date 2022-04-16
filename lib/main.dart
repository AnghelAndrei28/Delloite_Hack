import 'package:digi_hack/CustomMark.dart';
import 'package:digi_hack/ReportScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: { ReportScreen.routName: (ctx) => ReportScreen()
      },
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  late GoogleMapController mapController; //contrller for Google map
  final Set<CustomMark> markers = new Set(); //markers for google map
  late LatLng currentLocation = const LatLng(44.483071, 26.111524);
  late bool report = false;

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

  @override
  Widget build(BuildContext context) {
    _newEntry();
    return  Scaffold(
      appBar: AppBar(
        title: Text("Multiple Markers in Google Map"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body:  GoogleMap( //Map widget from google_maps_flutter package
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
        )
    );
  }

  _handleTap(LatLng point) async{
    var result = await  Navigator.pushNamed(context, ReportScreen.routName, arguments: point);
    setState(() {
      markers.add(CustomMark(
        MarkerId(point.toString()),
        "userID",
        report,
        point,
          "$result"
      ));
    });
  }

  Set<Marker> getmarkers() { //markers to place on map

    return [...markers].where((element) => element.type).toSet();
  }
}