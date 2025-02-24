import 'package:flutter/material.dart';
import 'package:app_blocker/models/profile.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _appsController = TextEditingController();
  DateTimeRange? _blockingPeriod;

  @override
  void dispose() {
    _nameController.dispose();
    _appsController.dispose();
    super.dispose();
  }

  Future<void> _selectBlockingPeriod(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDateRange: _blockingPeriod,
    );
    if (picked != null) {
      setState(() {
        _blockingPeriod = picked;
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate() && _blockingPeriod != null) {
      final profile = Profile(
        name: _nameController.text,
        appsToBlock: _appsController.text.split(','),
        blockingPeriod: _blockingPeriod!,
      );
      Navigator.pop(context, profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Profile Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a profile name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _appsController,
                decoration: const InputDecoration(
                  labelText: 'Apps to Block (comma-separated)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one app';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectBlockingPeriod(context),
                child: const Text('Select Blocking Period'),
              ),
              if (_blockingPeriod != null)
                Text(
                  'Blocking Period: ${_blockingPeriod!.start.toLocal()} - ${_blockingPeriod!.end.toLocal()}',
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
