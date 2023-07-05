import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const kDefaultBorderRadius = BorderRadius.all(Radius.circular(15));
LatLng kDefaultLocation = const LatLng(37.938909783732505, 58.39080121860015);
LatLngBounds kMaxBounds = LatLngBounds(
    const LatLng(37.78660289966499, 57.906994477092816),
    const LatLng(38.22705792064904, 58.92085303665987));
const kPhysics = BouncingScrollPhysics();
const int kLimit = 20;
