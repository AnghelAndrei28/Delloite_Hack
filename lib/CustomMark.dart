import 'package:digi_hack/Random.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// true pentru pierdut
// false pentru gasit
class CustomMark extends Marker{
  late String id;
  late String userId;
  late bool lost;
  late BuildContext context;
  CustomMark(String id, MarkerId markerId, String userId, bool type, LatLng point, String description, BuildContext context) : super(markerId: markerId, position: point, infoWindow: InfoWindow(title: description, onTap:() => Navigator.pushNamed(context ,Random.routName, arguments: id))) {
    this.lost = type;
    this.userId = userId;
    this.context = context;
  }
}