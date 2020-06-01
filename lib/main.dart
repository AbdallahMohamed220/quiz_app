import 'package:flutter/material.dart';
import 'package:quizer/screens/splashScreen.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        //  ResponsiveWidgets().init(
        //   referenceHeight: MediaQuery.of(context).size.height, // Optional
        //   referenceWidth: MediaQuery.of(context).size.width, // Optional
        //   referenceShortestSide:
        //       MediaQuery.of(context).size.shortestSide, // Optional, default = 360
        //   child:
        MaterialApp(
      home: SplashScreen(),
      // ),
    );
  }
}
