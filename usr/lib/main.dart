import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/character_detail_screen.dart';
import 'screens/vehicle_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Military Command App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/character': (context) => const CharacterDetailScreen(),
        '/vehicle': (context) => const VehicleDetailScreen(),
      },
    );
  }
}
