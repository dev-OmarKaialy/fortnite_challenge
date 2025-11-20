import 'package:flutter/material.dart';
import 'package:fortnite_challenge/screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
            iconSize: 12,
            textStyle: TextTheme.of(context).titleMedium?.copyWith(fontWeight: FontWeight.bold),
            backgroundColor: Colors.white,

            foregroundColor: Colors.black,
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
