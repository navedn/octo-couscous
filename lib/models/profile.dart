import 'package:flutter/material.dart';

class Profile {
  final String name;
  final List<String> appsToBlock;
  final DateTimeRange blockingPeriod;

  Profile({
    required this.name,
    required this.appsToBlock,
    required this.blockingPeriod,
  });
}
