import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'pages/home.page.dart';

void main() {
  return runApp(const CupertinoParkingSystemApp());
}

class CupertinoParkingSystemApp extends StatelessWidget {
  const CupertinoParkingSystemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white),
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Parking System",
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'SF',
      ),
      home: const CupertinoStoreHomePage(),
    );
  }
}
