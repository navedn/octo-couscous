import 'package:app_blocker/models/database_helper.dart';
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
  final DatabaseHelper _dbHelper = DatabaseHelper();

  ProfileNotifier() : super([]) {
    loadProfiles();
  }

  Future<void> loadProfiles() async {
    final profiles = await _dbHelper.getProfiles();
    state = profiles;
  }

  Future<void> addProfile(Profile profile) async {
    await _dbHelper.insertProfile(profile);
    loadProfiles(); // Reload profiles from the database
  }

  Future<void> removeProfile(int id) async {
    await _dbHelper.deleteProfile(id);
    loadProfiles(); // Reload profiles from the database
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
