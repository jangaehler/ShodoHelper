import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shodo_helper/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'kAppTitle',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
