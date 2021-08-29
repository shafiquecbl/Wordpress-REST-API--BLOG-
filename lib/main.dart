import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.notoSerif().fontFamily,
      ),
      title: 'Wordpress Demo',
      home: MyHomePage(),
    );
  }
}
