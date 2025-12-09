import 'package:flutter/material.dart';

class Pokemon {
  final String name;
  final String id;
  final String imageUrl;
  final Color color;
  final List<String> types;
  final double weight;
  final double height;
  final List<String> moves;
  final String description;
  final Map<String, int> stats;

  const Pokemon({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.color,
    required this.types,
    required this.weight,
    required this.height,
    required this.moves,
    required this.description,
    required this.stats,
  });
}
