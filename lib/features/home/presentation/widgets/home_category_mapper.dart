import 'package:flutter/material.dart';

class HomeCategoryMapper {
  const HomeCategoryMapper._();

  static IconData iconFor(String category) {
    switch (category.toLowerCase()) {
      case 'road signs':
        return Icons.warning_rounded;
      case 'road markings':
        return Icons.add_road;
      case 'traffic rules':
        return Icons.gavel;
      case 'speed limits':
        return Icons.speed;
      case 'hazard awareness':
        return Icons.report_problem;
      case 'safe driving':
        return Icons.directions_car;
      case 'vehicle handling':
        return Icons.directions_car;
      case 'motorway rules':
        return Icons.route;
      case 'pedestrian crossings':
        return Icons.directions_walk;
      case 'emergency procedures':
        return Icons.sos;
      default:
        return Icons.school;
    }
  }

  static Color colorFor(String category) {
    switch (category.toLowerCase()) {
      case 'road signs':
        return Colors.red;
      case 'road markings':
        return Colors.grey;
      case 'traffic rules':
        return Colors.green;
      case 'speed limits':
        return Colors.orange;
      case 'hazard awareness':
        return Colors.purple;
      case 'safe driving':
        return Colors.teal;
      case 'vehicle handling':
        return Colors.blue;
      case 'motorway rules':
        return Colors.greenAccent;
      case 'pedestrian crossings':
        return Colors.amber;
      case 'emergency procedures':
        return Colors.redAccent;
      default:
        return Colors.blueGrey;
    }
  }
}
