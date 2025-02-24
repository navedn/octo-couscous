import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_blocker/models/profile.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class ProfileNotifier extends StateNotifier<List<Profile>> {
  ProfileNotifier() : super([]);

  void addProfile(Profile profile) {
    state = [...state, profile];
  }

  void removeProfile(Profile profile) {
    state = state.where((p) => p != profile).toList();
  }
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, List<Profile>>((ref) {
  return ProfileNotifier();
});

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
