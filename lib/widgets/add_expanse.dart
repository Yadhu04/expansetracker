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
  // DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ExpanseProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Consumer<ExpanseProvider>(builder: (context, value, child) {
        return Column(
          children: [
            TextField(
              controller: data.titleController,
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
                    controller: data.amountController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      label: Text('Amount'),
                      prefixText: '\$ ',
                    ),
                  ),
                ),
                const Spacer(),
                data.selectedDate == null
                    ? const Text('select a Date')
                    : Text(formattter.format(data.selectedDate!)),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                    onPressed: () {
                      data.presentDatePicker(context);
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
                    value: data.selectedCatagory,
                    items: Catagory.values
                        .map((catagory) => DropdownMenuItem(
                            value: catagory, child: Text(catagory.name)))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      data.selectedCatagory = value;
                    }),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      data.checkField(context);
                    },
                    child: const Text("save"))
              ],
            )
          ],
        );
      }),
    );
  }
}
