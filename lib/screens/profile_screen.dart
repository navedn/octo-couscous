import 'package:app_blocker/main.dart';
import 'package:app_blocker/screens/create_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final profile = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateProfileScreen()),
              );
              if (profile != null) {
                ref.read(profileProvider.notifier).addProfile(profile);
              }
            },
          ),
        ],
      ),
      body: profiles.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You have no profiles yet"),
                  const SizedBox(height: 20),
                  const Text("Create a profile and manage your blockings"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final profile = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateProfileScreen()),
                      );
                      if (profile != null) {
                        ref.read(profileProvider.notifier).addProfile(profile);
                      }
                    },
                    child: const Text('Create'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return ListTile(
                  title: Text(profile.name),
                  subtitle: Text(
                      'Blocks: ${profile.appsToBlock.join(', ')}\nPeriod: ${profile.blockingPeriod.start.toLocal()} - ${profile.blockingPeriod.end.toLocal()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(profileProvider.notifier)
                          .removeProfile(profile.id!);
                    },
                  ),
                );
              },
            ),
    );
  }
}
