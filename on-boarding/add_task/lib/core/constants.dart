import 'package:flutter/material.dart';

const Color primaryColor = Color.fromRGBO(235, 80, 80, 1);
const Color secondaryColor = Color.fromRGBO(237, 232, 232, 1);
const Color black = Color.fromRGBO(0, 0, 0, 1);
const Color grey300 = Color.fromRGBO(68, 66, 66, 1);

const TextStyle titleStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins',
  color: black,
);

const TextStyle subtitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: grey300,
);

const TextStyle bodyStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: grey300,
);

const TextStyle titleMedium = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: black,
);

const TextStyle propertyNameStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);

const TextStyle propertyValueStyle = TextStyle(
  fontSize: 18,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  color: black,
);

ThemeData LightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: secondaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: secondaryColor,
    elevation: 0.0,
    iconTheme: IconThemeData(color: primaryColor),
  ),
);
