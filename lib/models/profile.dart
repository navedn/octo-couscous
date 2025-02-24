import 'package:flutter/material.dart';

class Profile {
  final int? id;
  final String name;
  final List<String> appsToBlock;
  final DateTimeRange blockingPeriod;

  Profile({
    this.id,
    required this.name,
    required this.appsToBlock,
    required this.blockingPeriod,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'appsToBlock': appsToBlock.join(','),
      'start': blockingPeriod.start.toIso8601String(),
      'end': blockingPeriod.end.toIso8601String(),
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      name: map['name'],
      appsToBlock: map['appsToBlock'].split(','),
      blockingPeriod: DateTimeRange(
        start: DateTime.parse(map['start']),
        end: DateTime.parse(map['end']),
      ),
    );
  }
}
