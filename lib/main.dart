import 'package:flutter/material.dart';
import 'package:posh_boys_v3/theme/app_colors.dart';
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
        scaffoldBackgroundColor: AppColors.backgroundDeepBlack,
      ),
      home: const HomeScreen(),
    );
  }
}
