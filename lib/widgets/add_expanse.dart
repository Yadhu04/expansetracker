import 'package:expansetracker/models/expanse_model.dart';
import 'package:expansetracker/provider/expanse_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpanse extends StatefulWidget {
  const AddExpanse({super.key});

  @override
  State<AddExpanse> createState() => _AddExpanseState();
}

class _AddExpanseState extends State<AddExpanse> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();
  DateTime? selectedDate;
  Catagory selectedCatagory = Catagory.pleasure;
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ExpanseProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLength: 20,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$ ',
                  ),
                ),
              ),
              const Spacer(),
              selectedDate == null
                  ? const Text('select a Date')
                  : Text(formattter.format(data.selectedDate)),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                  onPressed: () {
                    void presentDatePicker(BuildContext context) {
                      final currentDate = DateTime.now();
                      final firstdate = DateTime(currentDate.year - 1,
                          currentDate.month, currentDate.day);

                      showDatePicker(
                              context: context,
                              firstDate: firstdate,
                              lastDate: currentDate,
                              initialDate: currentDate)
                          .then((value) => setState(() {
                                selectedDate = value;
                              }));
                    }
                  },
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              DropdownButton(
                value: selectedCatagory,
                items: Catagory.values
                    .map((catagory) => DropdownMenuItem(
                        value: catagory, child: Text(catagory.name)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    selectedCatagory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    data.registerdexpense.add(Expanse(
                        title: titleController.text,
                        amount: double.parse(amountController.text),
                        date: data.selectedDate,
                        catagory: selectedCatagory));
                    Navigator.pop(context);
                  },
                  child: const Text("save"))
            ],
          )
        ],
      ),
    );
  }
}
