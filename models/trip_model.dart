import 'package:flutter/material.dart';

class Trip {
  final String id;
  final String from;
  final String to;
  final DateTime date;
  final double price;
  final String driverName;
  final String carModel;

  Trip({
    required this.id,
    required this.from,
    required this.to,
    required this.date,
    required this.price,
    required this.driverName,
    required this.carModel,
  });
}
