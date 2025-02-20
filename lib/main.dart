import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Blocker App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => ProfileScreen(),
        // '/login': (context) => LoginScreen(),
        // '/register': (context) => RegisterScreen(),
        // '/home': (context) => HomeScreen(),
        // '/profile': (context) => ProfileScreen(),
        // '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
