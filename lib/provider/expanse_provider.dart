import 'package:expansetracker/models/expanse_model.dart';
import 'package:flutter/material.dart';

class ExpanseProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   titleController.dispose();
  //   amountController.dispose();
  // }

  DateTime? selectedDate;
  Catagory selectedCatagory = Catagory.pleasure;
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

  void presentDatePicker(BuildContext context) {
    final currentDate = DateTime.now();
    final firstdate =
        DateTime(currentDate.year - 1, currentDate.month, currentDate.day);

    showDatePicker(
            context: context,
            firstDate: firstdate,
            lastDate: currentDate,
            initialDate: currentDate)
        .then((value) => selectedDate = value);
    print(selectedDate);
    notifyListeners();
  }

  addNewdata(BuildContext context) {
    registerdexpense.add(Expanse(
        title: titleController.text,
        amount: double.parse(amountController.text),
        date: selectedDate!,
        catagory: selectedCatagory));
    notifyListeners();
    titleController.clear();
    amountController.clear();
    selectedDate = null;

    Navigator.pop(context);
  }

  checkField(BuildContext context) {
    final enteredAmount = double.tryParse(amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        invalidAmount ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text("Enter a valid title,amount,date"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      );
      return;
    }
    addNewdata(context);
  }

  removeExpanse(index, BuildContext context) {
    if (index < 0 || index >= registerdexpense.length) {
      // Invalid index, do nothing
      return;
    }
    var removedExpanse = registerdexpense[index];

    registerdexpense.removeAt(index);
    notifyListeners();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      content: const Text('Expanse Deleted'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            registerdexpense.insert(index, removedExpanse);
            notifyListeners();
          }),
    ));
  }
}
