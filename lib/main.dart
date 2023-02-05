import 'package:backbone_tennis/game_screen.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

void main() async {
  // Turn the game to fullscreen
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
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
