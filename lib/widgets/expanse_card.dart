import 'package:expansetracker/models/expanse_model.dart';
import 'package:expansetracker/provider/expanse_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpanseCard extends StatelessWidget {
  const ExpanseCard({super.key, required this.index});
  final index;

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ExpanseProvider>(context, listen: false);
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.registerdexpense[index].title.toUpperCase()),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text("\$ ${data.registerdexpense[index].amount}"),
                const Spacer(),
                Row(
                  children: [
                    Icon(catagoryIcons[data.registerdexpense[index].catagory]),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(data.registerdexpense[index].FormatedDate)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
