import 'package:backbone_tennis/game_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backbone Dash Tennis',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
