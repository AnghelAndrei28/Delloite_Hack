import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// true pentru pierdut
// false pentru gasit
class CustomMark extends Marker{
  late String id;
  late String userId;
  late bool type;
  CustomMark(String id, MarkerId markerId, String userId, bool type, LatLng point, String description) : super(markerId: markerId, position: point, infoWindow: InfoWindow(title: description)) {
    this.type = type;
    this.userId = userId;
  }
}