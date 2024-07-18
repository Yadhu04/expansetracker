import 'package:expansetracker/models/expanse_model.dart';
import 'package:flutter/material.dart';

class ExpanseProvider extends ChangeNotifier {
  late DateTime selectedDate;

  List<Expanse> registerdexpense = [
    Expanse(
        title: 'movie',
        amount: 170,
        date: DateTime.now(),
        catagory: Catagory.pleasure),
    Expanse(
        title: 'nepal',
        amount: 1700,
        date: DateTime.now(),
        catagory: Catagory.travel)
  ];
}
