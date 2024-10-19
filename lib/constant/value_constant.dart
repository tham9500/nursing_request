import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// font size
const fontSizeXS = 10.0;
const fontSizeS = 12.0;
const fontSizeM = 14.0;
const fontSizeL = 16.0;
const fontSizeXL = 18.0;
const fontSizeXXL = 20.0;
const fontSizeXXXL = 30.0;
const fontAppBar = 22.0;
const fontIntro = 30.0;
const borderRadius = 10.0;
const elevation = 1.0;

// shadow
List<BoxShadow> customBoxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1.0,
    blurRadius: 5.0,
    offset: const Offset(1.0, 1.0),
  )
];

// font color
const textColorWhite = Colors.white;
const textColorBlack = Colors.black87;
const textColorGrey = Colors.grey;
const textColorGreen = Color.fromRGBO(45, 206, 152, 1);

// color
const primaryColor = Color.fromRGBO(1, 158, 223, 1);
const secondaryColor = Color.fromRGBO(203, 214, 249, 1);

// maps
const markerColor = Color.fromRGBO(250, 45, 77, 1);
const statusColor1 = Colors.green; // running
const statusColor2 = Colors.yellow; // engine on
const statusColor3 = Colors.red; // engine off
const statusColor4 = Colors.grey; // connection error
const statusColor5 = Colors.black87; // unknown

// margin
const double margin = 8.0;
const double marginX2 = 16.0;
const double marginX3 = 24.0;
const double marginX4 = 32.0;
const double marginX5 = 40.0;
const double marginX6 = 60.0;

// bottom navigation bar
const navigationBarHeight = 65.0;

const LatLng initialCameraPosition = LatLng(13.764906, 100.538352);
