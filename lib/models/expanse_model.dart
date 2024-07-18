import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uid = Uuid();
final formattter = DateFormat.yMd();

enum Catagory { food, travel, work, pleasure }

final catagoryIcons = {
  Catagory.food: Icons.food_bank,
  Catagory.pleasure: Icons.movie,
  Catagory.travel: Icons.flight_takeoff_outlined,
  Catagory.work: Icons.work
};

class Expanse {
  Expanse(
      {required this.title,
      required this.amount,
      required this.date,
      required this.catagory})
      : id = uid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Catagory catagory;

  String get FormatedDate {
    return formattter.format(date);
  }
}
