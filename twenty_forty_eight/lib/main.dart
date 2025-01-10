import 'package:flutter/material.dart';
import 'ui/home_screen.dart'; // Chemin correct pour HomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2048 Game',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: GameScreen(), // Utilise HomeScreen comme écran principal
    );
  }
}
