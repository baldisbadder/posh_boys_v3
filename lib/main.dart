import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat', //apply Montserrat globally
        scaffoldBackgroundColor: const Color(0xFF1C1C1C),
      ),
      home: const HomeScreen(),
    );
  }
}
