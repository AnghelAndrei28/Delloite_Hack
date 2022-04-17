import 'package:digi_hack/CustomMark.dart';
import 'package:digi_hack/MainScreen.dart';
import 'package:digi_hack/MapScreen.dart';
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
      routes: {
        ReportScreen.routName: (ctx) => ReportScreen(),
        MapScreen.routName: (ctx) => MapScreen(),
        MainScreen.routName: (ctx) => MainScreen(),
      },
      home: MainScreen(),
    );
  }
}

