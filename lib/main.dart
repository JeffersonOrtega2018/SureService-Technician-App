import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI/Auth/login_screen.dart';
import 'UI/General/home_page_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences? prefs;
  int? id;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SureService Technician App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (id != null) ? const HomeScreen() : const LoginScreen(),
    );
  }

  Future initialize() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs!.getInt("id");
    });
  }
}
